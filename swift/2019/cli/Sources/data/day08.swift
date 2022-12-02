
public struct Day08 {
    public static let input: String = """
021222211201202220222222222222222222221022222222122222222222122222222222222222021222222022202121222220222222022222220212222222222222222221222212222122021222212212222221222222222222222222220222222222022222222222122222222222222222021222222222202120222220222222122222222212222222222222222211222222222022022222210211222220222222222222220222220222222222122222222222122222222222222222022222222222202020222220222222122222222222222222222022222212222202222022221222222222212222222222222222221222021222222222122222222222022222222222222222020222222122212220222221222222021222220222222222222222222202222212222222021222222211212222222222222222220222020022222222022222222222022222222222222222221222222122202221222220222222020222221222222222222022222222222212222022122222212200212220222222222222220222222222222222022222222222022222222222222222021222222122202121222222222222022222221202222222222022222222222202222022122222220221212222222222222222221222222022222222222222222222122222222222222122221222222222222221222222222222221222220212222222222022222200222202222022121222220200212222222222222222222222221122222222022222222222222222222222222222020222222222212122222220222222220222221202222222222222220202222212222022021222222201202221222222220222222222120222222222022222222222122222222222222222022222222222222021222222222222220222220212222222222122220212222222222222220222200211222222222222222222221222220222222222022222222222022222222222222222220222222022202120222222222222121222221202202222222222222221222202222022022222201220212222222222222222221222022022222222122222222222022222222222222122122222222222212222222220222222120222222212212222222122221211222202222222121222211202212222222222222222221222120022222222022222222222022222222222222122221222222122202220222220222222221222222202202222222122202222222202222222220222201220202222222222220222222222121122222222122222222222222222222222222122222222222122202022222222222222220222220202202222222222212220222222222122222222210211222222222222220222221222121122222222022222222222122222222222222122222222222222202221222221222222221222221212202222222222221220222212222022022222211202202221222222220222222222122122222222222222222222222221222222222122221222222022202221222220222222020222221222202222222222202212222212222122220222221201222222222220220222221222021222222222222222222222122220222222222022021222222222222222222212222222021222220212202222222022211210222202222122121222221220212222222222222222221222020122222222122222222222022220222222220022120222222022212220222200222222121222220202202222222122210201222202222122021222211200202221222222222222222222121122222222022222222222022221222222222122220222222222222021222201222222220222221212222222222222222221222222222022221222222201222221222221220022222222220222222222022222222222222221222222220122120222222122222221222210222222020222221222212222222222200221222212222022121222222210222221220222221222222222121122222222222222222222222222222222221022021222222122222221222201222222122222222212212222222022210212222202222022221222212200202222220222222022222222221222222222222222222222222222222222220122121222222122202022222210222222221222222202212222222022221211222212222222221222210201212221222221222022221222122022222222222222222222122221222222221222122222222222222022222202222222020222220202222222222122202200222202222022022222202220222221221221222122222222020222222222222222222222122222222222220122021022222022222222222212222222121222221222222222222122210210222202222022222222201200212220220222221222221222120222222222122222222222122222222222222022220022222122202120222211222222220222222202212222222022210210222222222022220222220201212222222222222022220222222022222222022222222222022222222222222022020122222022202021222200222222120222222222212222222022211200222202222022221222210221222221220221220122222222220022222222222222222222122220222222220122020222222222202021222221222222121222220212202222222222202202222222222112020222221210212222222221220022222222221222022222222222222222022222222222220022020022222122212222222221222222121222220202222222222222201220222222222012022222211211222222222220222022221222121122222222022222222222022222222222222222021122222122202020222200222222122222220222212222222220221211222222222222022222202221202220220220222122221222021022222222022222221222022221222222221222021122222222222021222211222222021222221222222122222221210200222222222002021222200221202222222222221022221222022122022222022222222222122220222222220022120022222122212200222201222222122222220212222122222120220220222212222202221222222201202222220220222122221222220222022222222222221222222221222222220022021122222122202001222210222122122222221222202122222221220222222202222212021222222220212220221221220122222222221222122222122222222222222222222222221222022022022222202122222202222022120222222212202122222122201200222202222202121022201220202220222221221122221222120222122222022222220222122220222222220022022122222222212221222212222222120222221222222122222221221200222222222022022022212200222220220220221122222222022222222222122222222222222222222222222222020022122022202000222201222022122222220202212122222020202221222212222112022122211202212221222221220122220222022222022222122222222222122222222222220122021222022122202112212222222222020222021212202222222220221211222222222012220222210200212220222220220022222222021022222220002222021222122220222022220222120022222022222210002221222122020222222212202122222120211222222222222012120222201221202220222222221122222222121022122222002222020222222222222022220022221222222022212111102221222022121221022212202122222220211221222220222122120122200222222222222222220222221222120022022221122222221222022222222022221222021122122222202001222220222022220220121212222122222020222211222202222202021022222211202220221220222022222222222222222222122222221222122220222222220022122222222122222101002220222022122220122212222222222020200220222211202102020022222212202220221220221122222222220022122220202222121222022220222222222122221122122122222212212200222022222220120212212020222121200212222201212112021022212202222222220221221222222222121222022220202222122222122022222022221022120022022022222010102202222222222221120212202021222122211221222202202202021222221221212221220222220022221202121022022221012022120222222022222222220122222222122222202112122202222222220222120202222021222222212221222212212112020022221211212222221221221022221222020022122220122222120222122122222222221022120222122222222221122201222022022221120202202220222120210210222211212122022022212001222222201220222122221212222022222220212022121222022121222122220022220022022022212012102200222022121222220202212122222222222210222202222012120022220212222221221221222122221212221122022222212122121222122122222222221122122022022022222222222202222122220222221202212020222120222222222200222112022222212212202222210221222222220212222122222222022122021222222222222222220122120222022222212102202201222222220222120212222021222122221202222222212212122122210112212220212220221122221222022122122222112222221222022122222222220122020122222022212212222212222122221221022202222221222022221222222202202012022122100221222220220221220222220212121222122220102022221222022121222022222022222022222022212112002202222022122221121202222222222021211211222201202122220222001212202220200221220022221202222122022222222122022222222021222222221022121122122122212212102222222222021222021212222121222121202210222211212122122222022120202222211221221122201212022122022221112022220222222121222022222222120122222022212021222222222222022222022212212020222021200221222210222102022122201100212220212220221022200201022122222220212022020222022222222122221222120022122022212100202210222022121222120202212022222222200221222220212202122122100201222221220221221122202211222222022220222222022222022020222222220222220100122222212202112222222222221220122222222222222221210202222201212202021222100120202221210220220022210200120022022221002122020222122021222122221222221122122122222222112201222022222222022212212120222220210222222202202222021022112011222220220221222122210200221022122220122222122222222020222222221022222202022222222221212212222122221220120222212020222122220201222220222102121202210112212120210220221022210211022222012220012222222222222222222222222122121020022222212020202210222122122222221202202221222221210222222211222112120012111221222020212221222022212222021222222220202122121222022121222122220122022202022222212112102200222222221221021212222222222022221221222201202222022202000202202220211222221020222202120222022222202022221222122021222022220022020220022222202022012220222122120222020222202220222122222210222220212002121222200100202121220221221120220200020022122221212022221222222220222122220122220100222222222200112220222022022220112222212021222122221200222202212212121022120021222020212220222120212001121222202220022022222222022122222022221022221002222220202220012200222022121221201222222220122020202211222222202112021022112100202120222222222220221210220222012222012222222222022122222222222022222002122220212102202220222022122222211212202120122221222202222221221002020202011010222122202220221122222001122122012220202022122222022121222122220122120011022020222102222200222122121222000212202220122220220221222201201012120002221022202122220221220220211112121222112221002022220222022221222222222222221202022121212102002202222222122222012202102122222121212212222220201012122222110002222020210222220021210101020022102222022222121222102122221222221222022000022020202112202221222222222222120202102021222122202211222212201202222012211101202120220220220022211101022022122220022022220222122120222222202122122222222220212012022202212122121220121222012121122221210211222221211102120012221111212120211220221120221101121222010220002122021222202022220122010022120120022020202102202220202222222220111222002220222120221202222200200102121212021000202022200220220020222121220122102221212122222222022220221120121122020010222222202020112210202122222220100202222220222220211211202201201222220012222020112120220222220120202221021022102221002122121222122022222022002122222110122020212010122210222222022222010212222021222221220222222211212122020121010000022122202222220222222000121122201221202122120222022020220121001022120100022120202112202210202022120220212202002020022221200201202220222102120221200021122000221221220121211211020022211220112122020222010121221021210022121210222220222001102222222022221222200202212221022210220212212200212012221112110102002112211221222222222001121022102221212022220202221121221022211122220201122122222022002222212022122222100202122222122020220221222211010002021021101100212210221221222221212202020222112122002022022212002122221022020222122112022021212000222202212122021220200222102121122101210212222212220122021202011021022022221221221010201211020022111022002122121222102120220121101022222101022022202020202210202022022222122222022022022022200200212202002222120200011110002000222222221010220121000122000120122022120222122122222022001222222110122221212011212202212222121021022222102220122000211202202202010002120001100021212221211222221102222200001122021221222022022212221121222021002022020200022222202112002202212222022021120212202222022200201212202210212200221021201001122020210221220000221021211122101022202122120222012122221022202022220122122122222000012202220022221021200212102021022002210211202202112101120122021022202112222222222122220111200122100220122022021222111120220222222122122111122122212121122222222222120022211202122121222111202210222211020001222211102002212110212220220111222222111122002121122222021202212222021121120122221112122222212221002200200222220020110202202221022002202212202200111200120222110200222202221220222221210220112222001021222222020202202022020020011222121001222222212202022212200222022122101202202021222021202222202210102222121122002112222010211222212220210111201022212121201222221222212020220121112122120220122222212000002221220222020021212222112220122022222221222222121220221200000102212012202220220202212111010222200121210022021212022221022222010122022200122021222111002220220222020020220002212020222001220222222211120212122222021000002100220221212120212212210022022121011222022212122022022021122022022010222021222222202201220222120121122202002120022220211221212220222212120000100101012020220221211011200021222012102220021222021212001020020020211122122100122220212022102222200122121020001022122121022102201200222220210222020001020010002111210122210001200011120112121021101122222222020020122122111102220221222121222201202212202222020120201022222222222011220202012212202221021121021120002102200221212000210111001022122020201222220202001020120120201222022210222022202211001220200122220022202202012121022012220200022210101101220212201220112021221021210221220111000012201220120122021202121121221220020002121221222121212221212201212122121222000022222020222112200221022102002000220102021121102222200220211100201200102112101120111122021212011222220022001002120011122022222000101221020122121222001102202221122102222212012120112121121222010201002110211220220101201112212002110221120022110212100222021221221102022220122101202220102201210222222222012202112201122012222210002211011221020212110102002011221121212121201100211002222120210222201222210222122121211022120210122010212121220222022222220220002210112211112201202220222202222202222211210100000210201121220021201222110212122221012222221212001120222122011112120200222000212000002212012222122121112120212200112211212200002112202111020110111010010212201021220210202100212022001221122122021202101122121020212112021002022121212012101201220222120121222001202222222222210200222210221220120220101110212021222021212000200211211222120221202122201212012122120121012222121100022222222120211212210122220122102100222002112100210210012211022222022211220210202211200120220000211002101122021021122022121222202120021022121112120211022021212210201222121022021121011010012120112201201211112121121201021110102221112020221020222110201021212212022220222222112222101122121121111112120020222212202122020212212022222021121120022222202121220220110001222202121201110221020122222020202121212100200222111222220022110202221120221221211122122010222211222102222210122222221222221112202011002200222221200120101210021111011001202012210221221000200022101222111120020222011222102122120222222012022112222101212122021202111022222122100211222210212202222202022002112211222222022020022121211020220211201000010122121021200102120222221220120021122122122100022000222101202220011222021122210122212110212002220201200021100011122000010021212120212122211200220212101212220221120212012222000022222122210012021000222112202122112211020022022221120010222011220220201222122221120020022110011110122000221221212102200122122122012022110022222222000021222120001102021210022110222201100202220122221020220121222002221022220220022002210001120121022200001201220022200202222100100112122220020212211212222222220021202112222010022101112022010221000122121222211222212211201011211222222201112010112112011112002212102012010212120212212020221001210210120120122202002111011110102210010110010100222010012100100202102100020100020211010011202110011200
"""
}
