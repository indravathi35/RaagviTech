@isTest
global class BatchTestMock implements HttpCalloutMock {

    global HTTPResponse respond(HTTPRequest req) {

        HttpResponse res = new HttpResponse();

        res.setHeader('Content-Type', 'application/json');

        res.setBody('Success');

        res.setStatusCode(200);

        return res;

    }

}