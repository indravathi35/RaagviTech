import { LightningElement,api } from 'lwc';

export default class OppFlowLwc extends LightningElement {
    @api OpportunityName;
    @api Description;
    @api CloseDate;
    @api StageName;

}