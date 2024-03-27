import { LightningElement,track } from 'lwc';
import CreateContactRecords from '@salesforce/apex/CreateContactRecords.CreateContactRecords';
import { ShowToastEvent } from "lightning/platformShowToastEvent";
export default class CreateContactRecord extends LightningElement{
    @track firstName;
    @track lastName;
    @track emailVal;
    @track phone;
    @track descripton;
    @track Button = true;
    @track Form = false;
    @track objVal = {
        FirstName:'',
        LastName:'',
        Phone:'',
        Email:'',
        Description:''
    }
    handleButton(){
        this.Form = true;
        this.Button = true;
    }
    
    handleFirstName(event){
        this.firstName = event.target.value;
        this.objVal.FirstName = this.firstName
        console.log(JSON.stringify(this.objVal))
    }
    handleLastName(event){
        this.lastName = event.target.value;
        this.objVal.LastName = this.lastName
        console.log(JSON.stringify(this.objVal))
    }
    handleEmailChange(event){
        this.emailVal = event.target.value;
        this.objVal.Email = this.emailVal
        console.log(JSON.stringify(this.objVal))
        
    }
    handlePhone(event){
        this.phone=event.target.value;
        this.objVal.Phone = this.phone
        console.log(JSON.stringify(this.objVal))
        
    }
    handleDescription(event){
        this.descripton=event.target.value;
        this.objVal.Description = this.description
        console.log(JSON.stringify(this.objVal))
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
    
    handleSubmit()
    { 
        if(this.isInputValid())
        {
        console.log('inside');
        CreateContactRecords({obj:this.objVal})
            .then(result => {
               
              // const resultValue = '0035j00001CcRSnAAN'; // Replace with your actual resultValue

              const recordURL = `/lightning/r/Contact/${result.Id}/view`;
              const evt = new ShowToastEvent({
                  title: 'Success',
                  message: 'Contact {1} created successfully ',
                  variant: 'success',
                  messageData: [
                      'Salesforce',
                      {
                          url: recordURL,
                          label: result.Id,
                      },
                  ],
              });
               this.dispatchEvent(evt);
               this.template.querySelector('form').reset();
               this.Form=false;   
            })
            .catch(error => {
                // TODO Error handling
                console.log('error message',error.body.message);
            });
        }
    }
    handleCancel() {
        {
            console.log('inside cancel');
            this.template.querySelector('form').reset();
        
        }
        this.Form=false;
        
        
    }
    
}