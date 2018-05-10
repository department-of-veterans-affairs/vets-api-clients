This document provides some details about how documents are processed by VA and its affiliates after they are submitted via the document upload API. 

A key fact for API users to understand is that once a submission reaches "received" status, it enters a workflow which involves human interaction/processing of the submitted documents. Therefore the expected time until submission status changes to either "processing" or "success" may be measured on the order of hours/days rather than seconds/minutes. API users should adjust their expectations accordingly. For example, frequent polling for status updates beyond the "received" status is not warranted.

![Document Processing Workflow](vba_documents/document_processing_workflow.png)

Description of processing workflow by VBA subject matter expert:
> “Received by DMHS” i.e. “Success,” means that it’s been received in our  mail portal and is ready to be worked by VA government staff.  On average, they complete processing of a mail packet within 7 days of receipt in the portal and then it’s uploaded to VBMS.  Our government staff have a work queue they use within the mail portal to assign and work various documents.  The way our mail portal process works, VA staff take action on mail in the portal before it is uploaded into VBMS.  This differentiates us from D2D or EVSS, where you upload documents, they go straight into VBMS and government staff never see them to take action unless there is a pending claim and they look at the eFolder. 
