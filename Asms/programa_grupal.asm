DATA:
    apretado    0
    time        0
    vida_1      3
    vida_2      3
    display     303h
    por_marcar  0b
    marcado_1   0b
    marcado_2   0b
    barcos_1    0b
    barcos_2    0b
    ganador     0
    luces_pares 0101010101010101b
    luces_impares 1010101010101010b


CODE:
    CALL std_io_btn_wait
    CALL std_io_btn_wait
    MOV B, barcos_1
    IN (B), 0
    CALL std_io_btn_wait
    MOV B, barcos_2
    IN (B), 0
    MOV A, (display)
    OUT A, 0
    juego:              //Rutina principal

        CALL turno1
        MOV A, (vida_2)
        CMP A, 0
        JEQ end

        CALL turno2
        MOV A, (vida_1)
        CMP A, 0
        JEQ end

        JMP juego


    turno1:

        MOV A, (marcado_1)
        OUT A, 1

        CALL std_io_btn_wait


        MOV B, por_marcar
        IN (B), 0


        MOV A, (marcado_1)
        OR A, (por_marcar)
        MOV (marcado_1), A


        MOV A, (barcos_2)
        AND A,(por_marcar)
        CMP A,0
        JEQ end_turno

        MOV B, A
        MOV A, (barcos_2)
        SUB A, B
        MOV (barcos_2), A

        MOV A, (vida_2)
        SUB A, 1
        MOV (vida_2), A


        MOV A, (display)
        SUB A, 1h
        MOV (display), A
        OUT A, 0

        JMP end_turno

    turno2:
        MOV A, (marcado_2)
        OUT A, 1

        CALL std_io_btn_wait

        MOV B, por_marcar
        IN (B), 0

        MOV A, (marcado_2)
        OR A, (por_marcar)
        MOV (marcado_2), A

        MOV A, (barcos_1)
        AND A,(por_marcar)

        CMP A,0
        JEQ end_turno

        MOV B, A
        MOV A, (barcos_1)
        SUB A, B
        MOV (barcos_1), A

        MOV A, (vida_1)
        SUB A, 1
        MOV (vida_1), A

        MOV A, (display)
        SUB A, 100h
        MOV (display), A
        OUT A, 0

        JMP end_turno

    end_turno:
        RET



end:
MOV A,750
CALL led_beep_par
CALL led_beep_impar
    JMP end

    led_beep_par: // Mseg en A, * en B
        PUSH A
        SHR A
        PUSH A
        MOV A,(luces_pares)
        OUT A,1
        POP A
        CALL std_wait_ms
        POP A
      RET

    led_beep_impar: // Mseg en A, * en B
        PUSH A
        SHR A
        PUSH A
        MOV A,(luces_impares)
        OUT A,1
        POP A
        CALL std_wait_ms
        POP A
      RET


  /////////////////Libreria std_io//////////////////////////////////////////
                    //
  std_io_btn_wait:		// * en A, * en B			//
   PUSH B				// Guarda B				//
   IN A,1				// Estado actual			//
   std_io_btn_wait_press_lp:						//
    IN B,1			// Nuevo estado				//
    CMP A,B			// Si ==				//
    JEQ std_io_btn_wait_press_lp	// Continuar				//
   XOR B,A			// Bits cambiados			//
   std_io_btn_wait_release_lp:						//
    IN A,1			// Nuevo estado				//
    AND A,B			// Bits aun cambiados			//
    CMP A,0			// SI != 0				//
    JNE std_io_btn_wait_release_lp// Continuar				//
   MOV A,B			// Bits cambiados a A			//
   POP B				// Recupera B				//
  RET				// Retorna Bit(s) en A			//
                    //
  //////////////////////////////////////////////////////////////////////////

  //////////////////Libraria wait //////////////////////////////////////////
                    //
  std_wait_abs_s_ms:		// Seg en A, Mseg en B			//
   PUSH B				// Guarda Mseg				//
   std_wait_abs_s:		 					//
    IN B,2			// Seg actual				//
    CMP A,B			// Seg > Seg actual			//
    JGT std_wait_abs_s		// Continuar espera			//
   POP B				// Recupera Mseg			//
   JMP std_wait_abs_s_sanity	// Comprobar sanidad de Seg		//
   std_wait_abs_ms_lp:							//
    MOV B,A			// Mseg a B				//
    POP A				// Recupera Seg				//
    std_wait_abs_s_sanity:						//
     PUSH B			// Guarda Mseg				//
     IN B,2			// Seg actual				//
     CMP A,B			// Seg != Seg actual			//
     JNE std_wait_abs_ms_end	// Terminar espera			//
     POP B			// Recupera Mseg			//
    PUSH A			// Guarda Seg				//
    MOV A,B			// Mseg a A				//
    IN B,3			// Mseg actual				//
    CMP A,B			// Mseg > Mseg actual			//
    JGT std_wait_abs_ms_lp	// Continuar espera			//
    MOV B,A			// Mseg a B				//
    POP A				// Recupera Seg				//
    RET				// Void					//
   std_wait_abs_ms_end:							//
   POP B				// Recupera Mseg			//
  RET				// Void					//
                    //
  std_wait_ms:			// Mseg en A, * en B			//
   PUSH A				// Guarda los Mseg			//
   PUSH B				// Guarda B				//
   IN B,3				// Mseg actual				//
   ADD A,B			// Mas Mseg delay			//
   IN B,2				// Seg actual				//
   std_wait_ms_divide_lp:							//
    CMP A,1000			// Si Mseg < 1000			//
    JLT std_wait_ms_divide_end	// Terminar divisi�n			//
    SUB A,1000			// Mseg - 1000				//
    INC B				// Seg ++				//
    JMP std_wait_ms_divide_lp	// Continuar divisi�n			//
   std_wait_ms_divide_end:						//
   XOR A,B			// Intercambiar registros		//
   XOR B,A			// 					//
   XOR A,B			//					//
   CALL std_wait_abs_s_ms		// Espera absoluta Seg Mseg		//
   POP B				// Recupera B				//
   POP A				// Recupera los Mseg			//
  RET				// Void					//
                    //
  //////////////////////////////////////////////////////////////////////////
