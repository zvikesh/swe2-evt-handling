CLASS zcl_mdm_prd_events_handler DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES bi_event_handler_static .

  PROTECTED SECTION.

  PRIVATE SECTION.

    CONSTANTS gc_evt_objkey TYPE swfdname VALUE '_EVT_OBJKEY'.

ENDCLASS.

CLASS zcl_mdm_prd_events_handler IMPLEMENTATION.

  METHOD bi_event_handler_static~on_event.

    TRY.

        DATA lv_product_no TYPE swo_typeid.

        event_container->get(
          EXPORTING
            name       = zcl_mdm_prd_events_handler=>gc_evt_objkey
          IMPORTING
            value      = lv_product_no
            returncode = DATA(lv_returncode)
        ).

        CALL FUNCTION 'CONVERSION_EXIT_MATN1_INPUT'
          EXPORTING
            input        = lv_product_no
          IMPORTING
            output       = lv_product_no
          EXCEPTIONS
            length_error = 1
            OTHERS       = 2.
        IF sy-subrc <> 0.
          " MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
          " WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
        ENDIF.

      CATCH cx_swf_cnt_elem_not_found.
      CATCH cx_swf_cnt_elem_type_conflict.
      CATCH cx_swf_cnt_unit_type_conflict.
      CATCH cx_swf_cnt_container.
    ENDTRY.


  ENDMETHOD.

ENDCLASS.
