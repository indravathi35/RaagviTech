// accountRelatedContacts.js
import { LightningElement, wire, track } from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import { updateRecord } from 'lightning/uiRecordApi';
import { refreshApex } from '@salesforce/apex';
import contactsByAccount from '@salesforce/apex/ContactController.contactsByAccount';

const FIELDS = ['Account.Name', 'Account.Id'];

const COLS = [
    { label: 'Contact Name', fieldName: 'Name', type: 'text' },
    {label:'Email',fieldName:'Email'},
    {label:'Phone',fieldName:'Phone'},
    { label: 'Description', fieldName: 'Description', type: 'text', editable: true },
];

export default class AccountRelatedContacts extends LightningElement {
    @track accountId;
    @track contacts = [];
    @track error;
    @track columns = COLS;
    @track draftValues = [];

    @wire(getRecord, { recordId: '$accountId', fields: FIELDS })
    wiredRecord({ error, data }) {
        if (data) {
            this.accountId = data.id;
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.accountId = undefined;
        }
    }

    connectedCallback()
    {
        contactsList({accId:this.accountId})
            .then((result) => {
                this.contacts = result;
            })
            .catch((error => {
            }));
    }

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