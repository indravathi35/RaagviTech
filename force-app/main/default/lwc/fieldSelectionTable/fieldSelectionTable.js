import { LightningElement, wire } from 'lwc';
import getAccountRecords from '@salesforce/apex/FieldsInAccount.getAccountRecords';
import updateRecords from '@salesforce/apex/FieldsInAccount.updateRecords';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
export default class FieldSelectionTable extends LightningElement {
    values = [];
    showDropdown = false;
    optionData = [];
    columns;
    table=false;
    datatable;
    isLoading = true;
    searchKey = '';
    filteredOptions = [];
    dummyoption;
    @wire(getObjectInfo, { objectApiName: ACCOUNT_OBJECT })
    wiredAccountInfo({ data, error }) {
        if (data) {
            const fields = data.fields;
            this.optionData = Object.keys(fields).map(field => ({
                label: fields[field].label,
                value: field ,
                selected: false
            }));

            this.dummyoption=this.optionData;
        } else if (error) {
            console.error('Error fetching account data:', error);
        }
    }
    renderedCallback(){
        getAccountRecords({fieldNames:this.values})
        .then(result => {
            this.datatable=result;
            
            console.log('datatta',JSON.stringify(this.datatable));
            
        })
        .catch(error => {
            console.error('Error fetching options', error);
        });

    }

    selectItem(event) {
        const selectedValue = event.currentTarget.dataset.id;
        const selectedOption = this.optionData.find(option => option.value === selectedValue);
        selectedOption.selected = !selectedOption.selected;
        if (selectedOption.selected) {
            this.values = [...this.values, selectedValue];
        } else {
            this.values = this.values.filter(value => value !== selectedValue);
        }
        this.showDropdown = true;
        console.log('alllll',this.values);
    }

    showOptions() {
        this.showDropdown = true;
    }
    closePill(event) {
        const value = event.currentTarget.name;
        const selectedOption = this.optionData.find(option => option.value === value);

        selectedOption.selected = false;
        this.values = this.values.filter(val => val !== value);
        console.log('vaoooo',this.values);
    }
    handleSave(){
        this.table=true;
        console.log('insave-',this.values);
        this.columns = this.values.map(field => ({
            label: field,
            fieldName: field,
            editable:true
        }));
        
       
    }
    handleCancel(){
        this.values=[];
        this.table=false;
        this.optionData.selected=false;
    }
    handleMouseOut(){
        this.showDropdown=false;
    }
     handleEditSave(event){
        console.log('in save---');
        const draftValues = event.detail.draftValues;
        console.log('draft--',JSON.stringify(draftValues));
    try {
        updateRecords({ recordsJson: JSON.stringify(draftValues) });
        this.clearDraftValues();
      
    } catch (error) {
      console.log('error while updating');
    }
}
  clearDraftValues() {
    const datatable = this.template.querySelector("lightning-datatable");
    if (datatable) {
      datatable.draftValues = null;
    }
  }

  
  handleSearchChange(event) {
    this.showDropdown=true;
    this.searchKey = event.target.value.toLowerCase();
    this.filterOptions();
}
filterOptions() {
    if(this.searchKey){
    this.filteredOptions = this.optionData.filter(option =>
        option.label.toLowerCase().includes(this.searchKey)
    );
    }
    else{
        this.filteredOptions= this.dummyoption;
    }
}
  

    }
    


