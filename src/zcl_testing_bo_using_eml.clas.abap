CLASS zcl_testing_bo_using_eml DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    DATA: lv_opr TYPE c VALUE 'R'.
  INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_testing_bo_using_eml IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    CASE lv_opr.
        WHEN 'C'.

            DATA: it_so_create TYPE TABLE FOR CREATE ZRAP_CDS_SO.

            it_so_create = VALUE #( ( so_id = '0002' customer = 'Max Mustermann'
                                      gross_amount = 2000 currency_code = 'USD'
                                      order_status = 'N'
                                      %control = VALUE #( so_id = if_abap_behv=>mk-on
                                                          customer = if_abap_behv=>mk-on
                                                          gross_amount = if_abap_behv=>mk-on
                                                          currency_code = if_abap_behv=>mk-on
                                                          order_status = if_abap_behv=>mk-on
                                                          )
                                        ) ).

            MODIFY ENTITIES OF ZRAP_CDS_SO
                ENTITY orders
                CREATE FROM it_so_create
                FAILED DATA(lt_failed)
                REPORTED DATA(lt_reported).

            IF lt_failed IS NOT INITIAL.
                out->write(
                    EXPORTING
                        data = lt_failed
                        name = 'failed' ).

            ENDIF.

        WHEN 'U'.

            DATA: it_instance_u TYPE TABLE FOR UPDATE ZRAP_CDS_SO.

            it_instance_u = VALUE #( ( so_id = '0002' order_status = 'A'
                                       %control = VALUE #( order_status = if_abap_behv=>mk-on )
                                    ) ).

            MODIFY ENTITIES OF ZRAP_CDS_SO
                ENTITY orders
                UPDATE FROM it_instance_u
                FAILED lt_failed
                REPORTED lt_reported.


        WHEN 'D'.

            DATA: it_instance_d TYPE TABLE FOR DELETE ZRAP_CDS_SO.

            it_instance_d = VALUE #( ( so_id = '0001' ) ).

            MODIFY ENTITIES OF ZRAP_CDS_SO
                ENTITY orders
                DELETE FROM it_instance_d
                FAILED lt_failed
                REPORTED lt_reported.

        WHEN 'R'.


    ENDCASE.

    COMMIT ENTITIES.

  ENDMETHOD.

ENDCLASS.
