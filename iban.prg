/**
 * Funciones IBAN. International Account Bank Number
 * (C)2012 Joaquim Ferrer Godoy <quim_ferrer@yahoo.es>
 * v.1       : 27-12-2012
 * v.2       : 27-01-2014
 * Iban      : Devuelve un IBAN valido, a partir del codigo ISO de Pais, 
 *             el codigo nacional bancario y la longitud especificada.
 * IbanDigit : Determina el Digito de Control de un IBAN
 * IbanCheck : Determina si un IBAN es correcto
 * IbanFormat: Devuelve un IBAN en formato papel (Grupo de 4 digitos)
 **/

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
 local cDC, cIban := alltrim(cAccount)
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

 cIban := substr( alltrim(cIban), 5 )
 cIban += str( at( substr(cCountry,1,1), cAlgorithm ) +9, 2, 0 )
 cIban += str( at( substr(cCountry,2,1), cAlgorithm ) +9, 2, 0 )
 cIban += cDC

 do while len(cIban) > 3
   cDC   := str( val(substr( cIban, 1, 9 )) % 97, 2 )
   cIban := cDC + substr( cIban, 10 )
 enddo
 
return( val(cDC) == 1 )

//----------------------------------------------------------------//

function IbanFormat( string )

 local strIban 
 local n, nLen := len(string)

  if !empty(string) 
      strIban := 'IBAN '
      for n = 1 to nLen step 4
          strIban += substr( string, n, 4 ) +" "
      next
  endif

return strIban 

//----------------------------------------------------------------//