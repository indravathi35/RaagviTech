import { LightningElement,api, wire,track } from 'lwc';
import contactsByAccount from '@salesforce/apex/ContactController.contactsByAccount';
import { updateRecord } from 'lightning/uiRecordApi';
import { refreshApex } from '@salesforce/apex';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
export default class RelatedContacts extends LightningElement {
    columns=[
        {label:'FirstName', fieldName:'FirstName'},
        {label:'LastName', fieldName:'LastName'},
        {label:'Email',fieldName:'Email'},
        {label:'Phone',fieldName:'Phone',type:'email'},
        {label:'Description',fieldName:'Description',editable:true}

    ]; 
    @api recordId;
    @track contacts = [];
    @track draftValues = [];
    @wire (contactsByAccount,{accountId:'$recordId'}) contacts;
    handleSave(event) {
        const updatedFields = event.detail.draftValues;

        // Update the draftValues (displayed changes) with the actual data
        this.contacts = this.contacts.map(item => {
            const matchingField = updatedFields.find(field => field.Id === item.Id);
            return matchingField ? { ...item, ...matchingField } : item;
        });

        // Save the changes to the server
        const promises = updatedFields.map(updatedItem => {
            const fields = {};
            fields['Id'] = updatedItem.Id;
            fields['Description'] = updatedItem.Description;

            const recordInput = { fields };
            return updateRecord(recordInput);
        });

        Promise.all(promises)
            .then(() => {
                // If successful, clear the draft values
                this.draftValues = [];
                return refreshApex(this.contacts);
            })
            .catch(error => {
                // Handle error
            });
    }

    handleRowAction(event) {
        // Handle row actions if needed
    }
    
 }