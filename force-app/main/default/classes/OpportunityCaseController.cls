public class OpportunityCaseController {

    public Opportunity opp { get; private set; }
    public Case newCase { get; private set; }

    public OpportunityCaseController(ApexPages.StandardController controller) {
        opp = (Opportunity)controller.getRecord();
        newCase = new Case();
    }

    public Boolean isAccountEditable {
        get {
            return opp.AccountId == null;
        }
    }

    public Boolean isAccountNotEditable {
        get {
            return opp.AccountId != null;
        }
    }

    public PageReference createCase() {
        // Populate case fields from opportunity
        newCase.Subject = opp.Name;
        newCase.AccountId = opp.AccountId;

        insert newCase;

        return new PageReference('/' + opp.Id);
    }
}