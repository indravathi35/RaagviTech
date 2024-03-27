import { LightningElement ,track} from 'lwc';
export default class PaymentComponent extends LightningElement {
    @track popup=false;
    @track payNowChecked=false;
    @track payLaterChecked=false;
    @track showError = false;
    handlebutton(){
        this.popup=true;
    }
    closeModal(){
        this.popup=false;
        this.showError = false;
        this.payNowChecked=false;
        this.payLaterChecked=false;
    }
    /*get existingCustomerRadioOptions() {
        return [
            { label: 'Pay now', value: true ,text:'Retry failed payment subscriptions,sale orders and add ones '},
            { label: 'Pay later', value: true,text:'Subscription ONLY -Schedule a new date for failed payments' },
        ];
    }*/

    handlevalidation(event){

        if (event.target.label === 'Pay now') {
            this.payNowChecked = true;
            this.payLaterChecked = false;
            this.showError=false;
        } else if (event.target.label === 'Pay later') {
            this.payNowChecked = false;
            this.payLaterChecked = true;
            this.showError=false;
        }
        this.validateSelection();
    }
    validateSelection() {
        if (!this.payNowChecked && !this.payLaterChecked) {
            this.showError = true;
            this.template.querySelector('.paynow').classList.add('redradio');
            this.template.querySelector('.paylater').classList.add('redradio');
            return false;
        }
        if(this.payNowChecked){
                console.log('ifif');
                this.template.querySelector('.paylater').classList.remove('redradio');
                this.showError=false;
                return true;
            }
        else{
                this.template.querySelector('.paynow').classList.remove('redradio');
                this.showError=false;
                return true;
        }

        
    }

   
    handlenextbutton(){
        if (this.validateSelection()) {
            this.payNowChecked=false;
            this.payLaterChecked=false;
            this.popup=false;

    }
} 

}