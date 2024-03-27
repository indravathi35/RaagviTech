import { LightningElement,track,api,wire } from 'lwc';
import getCases from '@salesforce/apex/GetAddress.getCases';
import getContacts from '@salesforce/apex/GetAddress.getContacts';
import insertContact from '@salesforce/apex/GetAddress.insertContact';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
const COLS=[  
    {label:'Name',fieldName:'Name', type:'text'},  
    {label:'Phone',fieldName:'Phone'},  
    {label:'Email',fieldName:'Email'}  
  ];
  
export default class Steppercom3 extends LightningElement {
    cols=COLS;
    @track altcon;
    @track firstName = '';
    @track lastName = '';
    @track email = '';
    @track phone='';
    @track currentStep = '1';
    @api ad;
    @api reccaseId;
    @track selectedValue;
    @track dropdownOptions;
    @track conList;
    @track slectedrows;
    @track conbut=false;
    @track selectedList=[];
    @track altconList=[];
    @track s3alt=false;
    @track selectcheck=[];
    @track value;

    handleOnStepClick(event) {
        this.currentStep = event.target.value;
    }

    get isStepOne() {
        
        return this.currentStep === "1";
    }

    get isStepTwo() {
        return this.currentStep === "2";
    }

    get isStepThree() {
        return this.currentStep === "3";
    }
    get isStepFour() {
        return this.currentStep === "4";
    }
    get isStepFive() {
        return this.currentStep === "5";
    }

    get isEnableNext() {
        return this.currentStep != "5";
    }

    get isEnablePrev() {
        return this.currentStep != "1";
    }

    get isEnableFinish() {
        return this.currentStep === "5";
    }

    handleNext(){
        
        if(this.currentStep == "1"){
            console.log('adddd====',this.ad);
            this.selectedValue=this.defaultValue;
            const All_Compobox_Valid = [...this.template.querySelectorAll('lightning-combobox')]
            .reduce((validSoFar, input_Field_Reference) => {
                input_Field_Reference.reportValidity();
                return validSoFar && input_Field_Reference.checkValidity();
            }, true);
            if(All_Compobox_Valid){
                this.currentStep = "2";  
                
            }
            else{
                const event = new ShowToastEvent({
                    title : 'Error',
                    message : 'Please select case.',
                    variant : 'error'
                });
                this.dispatchEvent(event);
            }
        }
        else if(this.currentStep == "2"){
            this.currentStep = "3";
        }
        else if(this.currentStep == "3"){
            this.selectedList=[];
            this.selectcheck=[];
            this.currentStep="4";
        }
        else if(this.currentStep == "4"){
            this.currentStep="5"

        }
    }
    handlePrev(){
        if(this.currentStep == "3"){
            this.selectedList=[];
            this.selectcheck=[];
            this.currentStep = "2";
            
        }
        else if(this.currentStep == "2"){
            this.currentStep = "1";   
        }
        else if(this.currentStep == "4"){
            this.currentStep="3";
        }
        else if(this.currentStep == "5"){
            this.currentStep="4";
        }
    }

    handleFinish(){

    }
    @wire(getCases, { recId: '$reccaseId' })
    wiredCases({ error, data }) {
        if (data) {
            this.dropdownOptions = data.map(caseRecord => ({
                label: caseRecord.CaseNumber+caseRecord.Subject,
                value: caseRecord.Id
            }));
        } else if (error) {
            
            console.error(error);
        }
    }

    @wire(getContacts, { recId: '$reccaseId' })
    wiredContacts({ error, data }) {
        if (data) {
            this.conList=data
            }
        else if (error) {
            
            console.error(error);
        }
    }
    handleChange(event){
        this.value = event.target.value;
        console.log('selop---',this.selectedValue);
        
    }
    handleContacts(){
        this.conbut=true;
        this.s3alt=false;
    }
    handleRowSelection(event){
        for (let i = 0; i < event.detail.selectedRows.length; i++) {
            this.selectedList.push(event.detail.selectedRows[i]);
    }
    }
    handleaddresident(){
        this.altcon=true;
    }
    handleFirstName(event){
        this.firstName = event.target.value;
        
    }
    handleLastName(event){
        this.lastName = event.target.value;
        
    }
    handleEmailChange(event){
        this.email = event.target.value;
        
        
    }
    handlePhone(event){
        this.phone=event.target.value;
        
        
    }
    handleSubmit(){
        console.log('insubmit...');
        insertContact({ 
            firstName: this.firstName, 
            lastName: this.lastName, 
            email: this.email, 
            phone:this.phone,
            
        })
        .then(contacts => {

            console.log('Contact inserted: ', contacts);
            this.altconList=[...this.altconList, ...contacts];;
           
            
        })
        .catch(error => {

            console.error('Error inserting contact: ', error.body.message);
        });
        this.altcon=false;
    }
    closeModal(){
        this.altcon=false;
    }
    handleAlternateContact(){
        this.conbut=false;
        this.s3alt=true;

    }
    handleselectcheck(event){
        for (let i = 0; i < event.detail.selectedRows.length; i++) {
            this.selectcheck.push(event.detail.selectedRows[i]);
    }
    }
}