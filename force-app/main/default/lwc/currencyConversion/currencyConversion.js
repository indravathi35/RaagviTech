import { LightningElement,track,api} from 'lwc';
import { FlowAttributeChangeEvent } from 'lightning/flowSupport';
export default class CurrencyConversion extends LightningElement {
    
    @api indiancurrencyval;
    @api othercurrencyval;
    @api value;
    get options() {
        return [
            { label: 'USD', value: 'USD' },
            { label: 'GBP', value: 'GBP' },
            { label: 'AUD', value: 'AUD' },
        ];
    }
    handleinput(event){
        this.indiancurrencyval=event.target.value;
    }
    handleradiochange(event){
         const val=event.detail.value;
         this.value=val;
        console.log('option---',this.value);
        if(val=='USD'){
            console.log('in if---');
            this.othercurrencyval=this.indiancurrencyval*0.012029443;
            console.log('othercon--',this.othercurrencyval);
        }
        else if(val=='GBP'){
             this.othercurrencyval=this.indiancurrencyval*0.0094446022;
             console.log('othercon--',this.othercurrencyval);
        }
        else{
            this.othercurrencyval=this.indiancurrencyval*0.0179288;
            console.log('othercon---',this.othercurrencyval);
        }
        
    }

        fetch(){
            const attributeChangeEvent = new FlowAttributeChangeEvent('indiancurrencyval', this.indiancurrencyval);
            this.dispatchEvent(attributeChangeEvent);
        
            const otherCurrencyChangeEvent = new FlowAttributeChangeEvent('othercurrencyval', this.othercurrencyval);
            this.dispatchEvent(otherCurrencyChangeEvent);
        
            const valueChangeEvent = new FlowAttributeChangeEvent('value', this.value);
            this.dispatchEvent(valueChangeEvent);
        }
    
}