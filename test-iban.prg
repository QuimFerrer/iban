/**
 * Test y funcion Iban()
 * (C)2012 Joaquim Ferrer Godoy <quim_ferrer@yahoo.es>
 * v.1       : 27-12-2012
 * Iban      : Devuelve un IBAN valido, a partir del codigo ISO de Pais, 
 *			   el codigo nacional bancario (CCC) y la longitud especificada.
 * IbanDigit : Determina el Digito de Control de un IBAN
 * IbanCheck : Determina si un IBAN es correcto
 **/

//----------------------------------------------------------------//

function main()

 local cPais := "ES"
 local cCCC  := "00120345030000067890"
 local nLen  := 24

  SET FIXED OFF
  SET DECIMALS TO 3

  ? Iban( cPais, cCCC, nLen )
  ? IbanCheck( "ES0700120345030000067890" )

return( NIL )

//----------------------------------------------------------------//

function Iban( cCountry, cAccount, nLen )

 local cIban

 if nLen  != len( cCountry+cAccount ) +2
 	cIban := "incorrect IBAN code"
 else
 	cIban := cCountry+ IbanDigit( cCountry, cAccount ) +cAccount
 endif

return( cIban )

//----------------------------------------------------------------//

function IbanDigit( cCountry, cAccount )

 local n
 local cDC, cIban := cAccount
 local cAlgorithm := "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
  
 cIban += str( at( substr(cCountry,1,1), cAlgorithm ) +9, 2, 0 )
 cIban += str( at( substr(cCountry,2,1), cAlgorithm ) +9, 2, 0 )
 cIban += "00"
 
 do while len(cIban) > 3
 	 cDC   := str( val(substr( cIban, 1, 9 )) % 97, 2 )
	 cIban := cDC + substr( cIban, 10 )
 enddo
 cDC := strzero( 98 - val(cDC), 2 )
 
return( cDC ) 

//----------------------------------------------------------------//

function IbanCheck( cIban )

 local cAlgorithm := "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
 local cCountry   := substr( cIban, 1, 2 )
 local cDC        := substr( cIban, 3, 2 )

 cIban := substr( cIban, 5 )
 cIban += str( at( substr(cCountry,1,1), cAlgorithm ) +9, 2, 0 )
 cIban += str( at( substr(cCountry,2,1), cAlgorithm ) +9, 2, 0 )
 cIban += cDC

 do while len(cIban) > 3
 	 cDC   := str( val(substr( cIban, 1, 9 )) % 97, 2 )
	 cIban := cDC + substr( cIban, 10 )
 enddo
 
return( val(cDC) == 1 )

//----------------------------------------------------------------//

