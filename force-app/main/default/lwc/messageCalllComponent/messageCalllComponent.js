import { LightningElement,wire,track,api } from 'lwc';
import fetchMetaListLwc from '@salesforce/apex/ButtonMetaHandler.fetchMetaListLwc';
import createTask from '@salesforce/apex/ButtonMetaHandler.createTask';
import createDraft from '@salesforce/apex/ButtonMetaHandler.createDraft';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class MessageCalllComponent extends LightningElement {
    @track fetchMeta=[];
    @track buttoncall;
    @track buttonmet;
    @track callpop=false;
    @track meetpop=false;
    @track subjectval2;
    @track subjectval;
    @track callpoplabel;
    @track meetpoplabel;
    @track value;
    @track wireddata;
    @track color1;
    @track draftpop=false;
    @track objVal={
        Subject:''
    }
    @track objVal2={
        Subject:''
    }
    @track event1;
    @track event2;


    // this.fetchedData = data.map(button => ({
    //     ...button,
    //     style: `background-color: ${button.color__c};`, 
    // }));
    @wire(fetchMetaListLwc)
     wiredContacts({ error, data }) {
        if (data) {
       
            this.fetchMeta = data;
           
            this.buttoncall= this.fetchMeta[0].MasterLabel;
            this.buttonmet=this.fetchMeta[1].MasterLabel;
            this.subjectval=this.fetchMeta[0].Subject__c;
            this.objVal.Subject=this.subjectval;
            this.subjectval2=this.fetchMeta[1].Subject__c;
            this.objVal2.Subject=this.subjectval2;
            this.callpoplabel=this.fetchMeta[0].poplabel__c;
            this.meetpoplabel=this.fetchMeta[1].poplabel__c;
            this.color1=this.fetchMeta[0].color__c;
            console.log('colo1---',this.color1);
            this.color2=this.fetchMeta[1].color__c;   
            this.template.querySelector('.button1').style=`background-color: ${this.color1};`
            this.template.querySelector('.button2').style=`background-color: ${this.color2};`
        } else if (error) {
    
            this.error = error;
    
        }
    }
    handleButtonClick(){
        console.log('data----',JSON.stringify(this.fetchMeta));
        console.log('label---',this.fetchMeta[0].MasterLabel);
        this.callpop=true;
        this.triggerEventContinuous();
    }
    closeModal(){
        this.callpop=false;
        clearInterval(this.intervalId);
        createDraft({obj:this.objVal})
       .then(result => {
            console.log('id-----',result);
        })
        .catch(error => {
            console.log('error message',error.body.message);
        });

    }
    closeModal2(){
        this.meetpop=false;
        clearInterval(this.intervalId);
        createDraft({obj:this.objVal2})
        .then(result => {
             console.log('id-----',result);
         })
         .catch(error => {
             console.log('error message',error.body.message);
         });
 
    }
    handlebuttonmeet(){
        this.meetpop=true;
    }
    handleSubject(event){
    this.subjectval=event.detail.value;
    console.log('sub---',this.fetchMeta[0].Subject);
    }
    get options() {
        return [
            { label: 'NewCall', value: 'NewCall' },
            { label: 'PerformCall', value: 'PerformCall' },
            { label: 'ScheduleCall', value: 'ScheduleCall'},
        ];
    }
    handleChange(event){
        this.value=event.detail.value;
    }
    handleTextArea(event){
        this.textAreaValue = event.target.value;
        console.log('Text Area',event.target.value);
    }
    SaveButton(){
        console.log('in save');
        createTask({obj:this.objVal})
       .then(result => {
            console.log('id-----',result);
            const evt = new ShowToastEvent({
                title: 'Success',
                message: 'Task created successfully ',
                variant: 'success',
            });
            this.dispatchEvent(evt);
            this.callpop=false;    
        })
        .catch(error => {
            console.log('error message',error.body.message);
        });
        clearInterval(this.intervalId);
    }
    SaveButton2(){
        createTask({obj:this.objVal2})
       .then(result => {
            console.log('id-----',result);
            const evt = new ShowToastEvent({
                title: 'Success',
                message: 'Task created successfully ',
                variant: 'success',
            });
            this.dispatchEvent(evt);
            this.callpop=false;    
        })
        .catch(error => {
            console.log('error message',error.body.message);
        });
        clearInterval(this.intervalId);
    }
    triggerEventContinuous(){
        console.log('e2---');
        this.intervalId = setInterval(() => {
            this.showToast();
        }, 5000);

    }
    showToast() {
        const event = new ShowToastEvent({
            title: 'Draft Saved',
            message: 'Your draft values have been saved.',
            variant: 'success',
        });
        this.dispatchEvent(event);
    }
    cancelButton1(){
       this.draftpop=true;
       clearInterval(this.intervalId);
    }
    cancelButton2(){
        this.draftpop=true;
        clearInterval(this.intervalId);
    }
    yesbutton(){
        this.draftpop=false;
        this.callpop=false;

    }
    nobutton(){
        this.draftpop=false;

    }
    closeModal3(){
        this.draftpop=false;
    }
    

    
}