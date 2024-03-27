import { LightningElement,api } from 'lwc';

export default class DatatableSelected extends LightningElement {
    @api columnval;
    columns;
    connectedCallback(){
        console.log('clll',JSON.stringify(this.columnval));
        this.columns = this.columnval.map(field => ({
            label: field,
            value: field,
        }));
        console.log('coli--',this.columns);
    }
}