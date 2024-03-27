trigger casecttrigger on Case (after update) {
    List<Contact> con=new List<Contact>();
    for(Case c:Trigger.new){
        if(c.Status=='Closed'){
            List<Contact> conlist=[SELECT Id,Description FROM Contact WHERE Id = :c.ContactId];
            for (Contact co : conlist) {
                co.Description = 'Case Closed';
                con.add(co);
            }
        }
    }
    if(!con.isEmpty()){
        update con;
    }
}