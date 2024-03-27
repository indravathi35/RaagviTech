import { LightningElement,api,wire} from 'lwc';
import AccountRelatedCase from '@salesforce/apex/AccountRelatedCase.AccountRelatedCase';
import getAccountFields from '@salesforce/apex/AccountRelatedCase.getAccountFields';
import getStatusPicklistValues from '@salesforce/apex/GetPickListValues.getPicklistValues';
import PriorityPicklistValues from '@salesforce/apex/GetPickListValues.PriorityPicklistValues';
import { subscribe,unsubscribe}  from 'lightning/empApi';
export default class TaskRealatedAccount extends LightningElement {
    @api recordId;
    formData={};
    statusError='';
    emailError='';
    phoneError='';
    PriorityError='';
    SubjectError='';
    statusoptions;
    priorityoptions;
    filter = {}
    isModalVisible = false
    subscription;
    recordUpdated = false;
    
    disconnectedCallback() {
        unsubscribe(this.subscription, (response) => {});
    }
    connectedCallback(){
        this.subscribeToEvent()
       this.filter = {
            criteria: [{
                    fieldPath: 'AccountId',
                    operator: 'eq',
                    value: this.recordId
            }]
    };

        getAccountFields({AccountId:this.recordId})
        .then(result => {
            this.formData = {
                Subject:result.Subject__c,
                Priority:result.priority__c,
                Phone:result.Phone__c,
                Email:result.email__c,
                Status: result.Status__c
            };
            
            console.log('Case added with ID');
            console.log('res--',JSON.stringify(result));

        })

        .catch(error => {

            console.error('Error adding case', error);

        });
        
    }
    renderedCallback(){
        getAccountFields({AccountId:this.recordId})
        .then(result => {
            this.formData = {
                Subject:result.Subject__c,
                Priority:result.priority__c,
                Phone:result.Phone__c,
                Email:result.email__c,
                Status: result.Status__c
            };
            
            console.log('Case added with ID');
            console.log('res--',JSON.stringify(result));

        })

        .catch(error => {

            console.error('Error adding case', error);

        });

    }
    @wire(getStatusPicklistValues, {})
    wiredRatingPicklistValues({ error, data }) {
        if (data) {
            console.log('data--',JSON.stringify(data));
            this.statusoptions= data.map(option => {
                return {
                    label: option.label,
                    value: option.value
                };
            });
        }
        else if (error) {
            console.error(error);
        }
    }
    @wire(PriorityPicklistValues, {})
    wiredPriorityPicklistValues({ error, data }) {
        if (data) {
            this.priorityoptions= data.map(option => {
                return {
                    label: option.label,
                    value: option.value
                };
            });
        }
        else if (error) {
            console.error(error);
        }
    }
    subscribeToEvent() {
        const messageCallback = (response) => {
            this.isModalVisible = true;
            this.recordUpdated=true
        };

        subscribe('/event/Record_Update_Event__e', -1, messageCallback).then(
            (response) => {
                
                
                this.subscription = response;
            }
        );
    }
    
    handleChange(event){

        this.formData[event.target.label] = event.target.value;
        
    }
    isInputValid() {
        let isValid = true;
        let inputFields = this.template.querySelectorAll('.validate');
        inputFields.forEach(inputField => {
            if(!inputField.checkValidity()) {
                inputField.reportValidity();
                isValid = false;
            }
        });
        return isValid;
    }
    
    handleSave(){
        console.log('in save');
        if(this.isInputValid()) {
           // this.formData.type = 'Case';
        AccountRelatedCase({ AccountId: this.recordId,obj:this.formData})

        .then(result => {

            console.log('Case added with ID');
            this.isModalVisible=false;
        })

        .catch(error => {

            console.error('Error adding case', error);

        });
        this.formData = {};
        this.isModalVisible=false;
        this.recordUpdated=false;
    }
    }
    handleCancel(){
        this.formData = {};
        this.isModalVisible=false;
        
    }
    hideModalBox(){
        this.isModalVisible=false;
    }
}