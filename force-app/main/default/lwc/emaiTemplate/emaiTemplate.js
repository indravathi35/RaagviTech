import { LightningElement,track,api,wire } from 'lwc';
import getContacts from '@salesforce/apex/EmailContacts.getContacts';
import getFolders from '@salesforce/apex/EmailContacts.getFolders';
import emailTemplates from '@salesforce/apex/EmailContacts.emailTemplates';
import sendEmailController from '@salesforce/apex/EmailContacts.sendEmailController';
const columns = [
   { label: 'Subject', fieldName: 'Subject' },
   { label: 'Body', fieldName: 'Body'},
];

export default class EmaiTemplate extends LightningElement {
    @track disabled=true;
    columns=columns;
    @track rowdata;
    @track label;
    @track len;
    @track op1data;
    @track op2data;
    @api recordId;
    @track selectedContact;
    @track showPicklistOptions;
    @track SelectedContactMail;
    @track temppop=false;
    @track folderoptions;
    @track value;
    @track Subject;
    @track textAreaValue;
    @track To=[];
    @wire(getContacts, {recId: '$recordId' })
    wiredContacts({ error, data }) {
       if (data) {
        this.showPicklistOptions=data;
        console.log('data---',JSON.stringify(this.showPicklistOptions));
       } else if (error) {
   
           this.error = error;
        }
   }
   handleSearch(event){
    console.log('in search----');
    this.selectedContact=event.target.value;
    console.log('con----',this.selectedContact);
    for(let i=0;i<this.showPicklistOptions.length;i++){
      console.log('in for---');
    if(this.selectedContact===this.showPicklistOptions[i].LastName){
        console.log('in if---');
        this.SelectedContactMail=this.showPicklistOptions[i].Email;
        this.disabled=false;

    }
   }
   if(this.selectedContact===''){
      this.SelectedContactMail='';
        this.disabled=true;
    }
 }
 selectTemplate(){
    this.temppop=true;
    
 }
 closeModal(){
    this.temppop=false;
 }
 @wire(getFolders)
 wiredFolders({ error, data }) {
   if (data) {
      this.folderoptions = Object.keys(data).map(key => ({
         label: data[key],
         value: key
     }));
     console.log('folderoppp--',JSON.stringify(this.folderoptions));
     this.value=this.folderoptions[0].value;
     console.log('default--',this.value);
   }
   else if (error){

        this.error = error;
     }
}


handleChange(event){
   this.value=event.target.value;
   console.log('select====',this.value);

emailTemplates({folderId:this.value})
.then(result => {
   console.log('res--',JSON.stringify(result));
   this.rowdata = result.map(folder => ({
      Subject: folder.Subject,
      Body: folder.Body
  }));

})

.catch(error => {

   console.error('Error sending mail', error);

});
}
handleRowAction(event){
   const selectedRows = event.detail.selectedRows;
   this.Subject=selectedRows[0].Subject;
  this.textAreaValue=selectedRows[0].Body;
   console.log('row----',selectedRows.Subject);
   this.temppop=false;

}
sendEmail(){
   sendEmailController({ toAddress: this.SelectedContactMail, subject: this.Subject,body:this.textAreaValue })

        .then(result => {

            console.log('Mail sent');

        })

        .catch(error => {

            console.error('Error sending mail', error);

        });
   this.Subject='';
   this.textAreaValue='';
   this.SelectedContactMail='';
   this.selectedContact='';

}
 
}