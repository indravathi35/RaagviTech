import { api, LightningElement, track, wire } from 'lwc';
import lookUp from '@salesforce/apex/Lookup.search';
export default class SearchBarAccConOppPro extends LightningElement {
    @api objName="Account";
    @api iconName="standard:account";
    @api filter = '';
    @api searchPlaceholder="Search Accounts";
    selectedName;
    records;
    isValueSelected;
    blurTimeout;
    searchTerm;
    @api accountId;
    
    boxClass = 'slds-combobox slds-dropdown-trigger slds-dropdown-trigger_click slds-has-focus';
    inputClass = '';
    @wire(lookUp, {searchTerm : '$searchTerm', myObject : '$objName', filter : '$filter'})
    wiredRecords({ error, data }) {
        console.log('dddddddddddd');
        if (data) {
            this.error = undefined;
            this.records = data;
        } else if (error) {
            this.error = error;
            this.records = undefined;
        }
    }
    handleClick() {
        this.searchTerm = '';
        this.inputClass = 'slds-has-focus';
        this.boxClass = 'slds-combobox slds-dropdown-trigger slds-dropdown-trigger_click slds-has-focus slds-is-open';
    }

    onBlur() {
        this.blurTimeout = setTimeout(() =>  {this.boxClass = 'slds-combobox slds-dropdown-trigger slds-dropdown-trigger_click slds-has-focus'}, 300);
    }

    onSelect(event) {
        let selectedId = event.currentTarget.dataset.id;
        this.accountId = selectedId;
        console.log('ID---',selectedId);
        let selectedName = event.currentTarget.dataset.name;
        const valueSelectedEvent = new CustomEvent('lookupselected', {detail:  selectedId });
        this.dispatchEvent(valueSelectedEvent);
        this.isValueSelected = true;
        this.selectedName = selectedName;
        if(this.blurTimeout) {
            clearTimeout(this.blurTimeout);
        }
        this.boxClass = 'slds-combobox slds-dropdown-trigger slds-dropdown-trigger_click slds-has-focus';
    }

    handleRemovePill() {
        this.isValueSelected = false;
    }

    onChange(event) {
        this.searchTerm = event.target.value;
    }

}