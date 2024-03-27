import { LightningElement } from 'lwc';

export default class TaskOne extends LightningElement {
    constructor(){
    super();
    timeElapsed=0;
    intervalId;
    }
    connectedCallback(){
        
        this.intervalId = setInterval(() => {
            this.timeElapsed++;
        }, 1000);

    }
    renderedCallback(){
        this.updateTimerDisplay();
    }
    
    disconnectedCallback() {
        
        clearInterval(this.intervalId);
    }
    updateTimerDisplay() {
        
        this.template.querySelector('p').textContent = `Elapsed Time: ${this.timeElapsed} seconds`;
    }
}