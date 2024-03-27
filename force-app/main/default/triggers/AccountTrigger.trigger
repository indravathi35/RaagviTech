trigger AccountTrigger on Account (after update) {
    TokenGenerator.token_Generator(Trigger.new);
}