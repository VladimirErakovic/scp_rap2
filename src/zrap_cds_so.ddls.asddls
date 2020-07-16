@AbapCatalog.sqlViewName: 'ZRAP_VE_SO'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Entity for RAP'
define root view ZRAP_CDS_SO as select from zrap_so {
   //zrap_so
   key so_id,
   customer,
   @Semantics.amount.currencyCode: 'currency_code'
   gross_amount,
   @Semantics.currencyCode: true
   currency_code,
   order_status 
}


