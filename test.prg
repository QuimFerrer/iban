/**
 * Test de funciones IBAN
 * (C)2012 Joaquim Ferrer Godoy <quim_ferrer@yahoo.es>
 * v.1       : 27-12-2012
 * v.2       : 27-01-2014
 **/

//----------------------------------------------------------------//

function main()

 local cPais := "ES"
 local cCCC  := "00120345030000067890"
 local nLen  := 24

  SET FIXED OFF
  SET DECIMALS TO 3

  ? repl("=", 80)
  ? "Test de funciones IBAN. International Bank Account Number"
  ? repl("=", 80)

  ? "Iban( cPais, cCCC, nLen ) : Convierte un CCC en IBAN", ;
  	Iban( cPais, cCCC, nLen )

  ? "IbanCheck( cIban )        : Determina si un IBAN es correcto", ;
  	IbanCheck( "ES0700120345030000067890" )

  ? "IbanDigit( cPais, cCCC )  : Calcula el DC de un IBAN a partir del Pais y CCC", ;
  	IbanDigit( "ES", "00120345030000067890" )
  
  ? "IbanFormat( cIban )       : Devuelve un IBAN en formato papel ( Grupos de 4 digitos )"
  ? IbanFormat( "ES0700120345030000067890" )

return( NIL )

//----------------------------------------------------------------//