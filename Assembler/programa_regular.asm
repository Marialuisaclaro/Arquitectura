DATA:
    num_grupo 9h
    seg3 3
    botones_apretados 0
    palabra 0b
    vidas 0000000011111111b

    jugada 0b

    luces_pares 0101010101010101b
    luces_impares 1010101010101010b

    palabra_xor 0
    dis 0


CODE:
    wait_num_grupo:
      MOV A, (num_grupo)
      OUT A, 0
      IN B,2
      MOV A,(seg3)
      CMP A,B
      JNE wait_num_grupo

    MOV A,0
    OUT A,0 //muestra 0 en display

    //seteo palabra
    CALL std_io_btn_wait //se espera a que se arete primer boton y se guardan switches
    MOV B, palabra
    IN (B), 0 // guarda en palabra los switches

    juego:
      MOV A, (vidas)
      OUT A,1

      CALL std_io_btn_wait

      //Leemos los switches levantados
      MOV B, jugada
      IN (B), 0

      //Vemos si le achuntó
      MOV A, (jugada)
      XOR A,(palabra)
      CMP A,0
      JEQ luces_navidenas

      //Si no, calculamos distancia

      MOV (palabra_xor),A

      distancia_hamming:
        MOV A, (palabra_xor)
        CMP A,0
        JEQ siguiente
        AND A,1
        CMP A,1
        JNE seguir
        MOV B, (dis)
        INC B
        MOV (dis),B
        seguir:
        MOV A, (palabra_xor)
        SHR A
        MOV (palabra_xor), A
        JMP distancia_hamming

      siguiente:
        MOV A, (vidas)
        SHR A
        OUT A,1
        MOV (vidas),A
        CMP A,0
        JEQ game_over

        MOV A, (dis)
        OUT A, 0
        MOV A,0
        MOV (dis),A
        JMP juego


    luces_navidenas:


        //MOV A, (luces_pares)
        //OUT A,1

        //wait:
        //  IN A,2
        //  AND A,1
        //  CMP A,1
        //  JEQ wait //Sigue si el segundo es par

        //MOV A, (luces_impares)
        //OUT A,1

        MOV A,750
        CALL led_beep_par
        CALL led_beep_impar
        JMP luces_navidenas

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

     game_over:
        MOV A,1057h
        OUT A,0
        JMP end
    end:
        JMP end

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
