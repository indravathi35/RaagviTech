public class LeadTriggerHandler {
    public static void updateAfterRevenue(List<Lead> leads) {
        List<Lead> leadsToUpdate = new List<Lead>();
        
        for (Lead lead : leads) {
            if (lead.Rating == 'Hot' && lead.AnnualRevenue < 100000) {
                lead.AnnualRevenue = 100000;
                leadsToUpdate.add(lead);
            }
        }
        
        if (!leadsToUpdate.isEmpty()) {
            try {
                update leadsToUpdate;
            } catch (Exception e) {
                System.debug('Error updating leads: ' + e.getMessage());
            }
        }
    }
}