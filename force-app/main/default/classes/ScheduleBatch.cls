public class ScheduleBatch implements Schedulable {
    public void execute(SchedulableContext context){
        BatchApexTask b=new BatchApexTask();
        database.executeBatch(b);
    }
}