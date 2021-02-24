"""
Data ini cuman 891 ya padahal kalau search di google jumlah penumpang Titanic
itu ada 1317 (search di tempat lain dan angkanya bakalan beda wkwkkwkw, bahkan
bisa sampe 2000an). Entah bagaimana 891 orang ini diambil. Kita main pake data
ini aja.

Kolom embark menyatakan dari pelabuhan mana mereka naik ke Titanic. C=Cherbourg
Q = Queenstown, S = Southampton. Sibsp menyatakan jumlah saudara yang naik ke
Titanic juga. Parch menyatakan jumlah orang tua atau anak yang naik ke Titanic
juga. 

Kita melihat bahwa penumpang pria jauh lebih banyak dibanding dengan penumpang
wanita. Pria itu 64.7% dari seluruh penumpang. Yang menarik adalah kalau kita
bandingkan dengan proporsi yang selamat, pria cuman 109/(233+109) = 31.8% nya.
Hal ini kemungkinan disebabkan karena pada proses evakuasi, kru kapal atau siapa
pun yang bertanggung jawab lebih mendahulukan wanita.

Hal ini juga bisa dilihat dari prob_survive_sex, yaitu variable yang menunjukkan
kemungkinan seseorang untuk selamat berdasarkan jenis kelamin, hasilnya adalah
kemungkinan selamat wanita adalah 74.2% sementara pria hanya 18.9%.

yang menarik adalah hampir tidak ada perbedaan antara rata2 umur penumpang (20.69)
dengan rata2 umur penumpang yang selamat (28.34). Kalau misalnya proses evakuasi
mendahulukan anak2 maka seharusnya rata2 umur penumpang selamat lebih rendah. Tapi
kenyataannya tidak jauh berbeda. hal ini bisa jadi disebabkan karena bukan cuman
anak2 yang didahulukan tapi juga orang tua. Dengan demikian umur anak2 dan org
tua saling menyeimbangkan rata2 menjadi dekat dengan rata2 umur penumpang.

Selain itu ada sebanyak 177 orang (19.8% obseervasi) yang kita tidak tau umurnya
saat kejadian. Hal ini bisa jadi menyebabkan data kita bias. dari 177 orang yg
umurnya tidak diketahui itu, 125 (70.6%) diantaranya tidak selamat. Kemungkinan
besar ya justru karena mereka mati makanya kita nggak tau umur mereka berapa.

Jadi kita tau 1 hal, yaitu bahwa sebagian besar org yang tidak diketahui umurnya
tidak selamat dari bencana ini. Kemungkinan besar mereka bukan anak2 dan orang
tua karena kalo mereka anak2 dan orang tua harusnya mereka didahulukan saat
evakuasi. Dengan demikian mereka adalah orang2 dewasa yang umurnya kurleb mirip
dengan umur rata2 penumpang. Harusnya mereka tidak akan mengubah mean rata2
seandainya secara ajaib umur mereka diketahui.

Hal yang menarik untuk dilihat adalah apakah ada perlakuan khusus terhadap
penumpang yang kelas atas. Penumpang dibagi jadi 3 kelas, yaitu kelas 1, 2, dan 3.
Kalau misalnya memang ada perlakuan khusus maka seharusnya ada perbedaan proporsi
kelas dari seluruh penumpang dan mereka yang selamat.

Hal ini keliatan jelas dari variable class dan class_survived. Class menunjukkan
proporsi kelas dari seluruh penumpang dan class_survived menunjukkan proporsi
kelas untuk penumpang yang selamat. Kelihatan jelas bahwa memang ada perlakuan
khusus kepada orang2 yang dari kelas 1.

Untuk lebih jelasnya lagi, variable prob_survive_class menunjukkan peluang seseorang
untuk selamat dari bencana ini berdasarkan kelas mereka saat naik ke Titanic.
The results speaks for it self.

Eh tunggu sebentar, ada kemungkinnan bahwa analisa tersebut tidak tepat. Bisa
jadi banyaknya perempuan di kelas 1 memang jauh lebih banyak dibandingkan kelas
lainnya dan hal ini yang menyebabkan probabilitynya condong ke kelas 1 karena
kita kan tadi sudah establish bahwa memang wanita kemungkinan selamatnya lebih
besar.

Berdasarkan variable female_proportion_class yang terlihat memang adalah bahwa
proporsi wanita di kelas 1 dan 2 nggak jauh beda, yaitu 41% sementara proporsi
wanita di kelas 3 cuman 30%. Perbedaan ini cuman 10% aja, terlalu kecil untuk
bisa menjelaskan perbedaan 38% kemungkinan selamat antara kelas 1 dan kelas 2.

Sebenernya kita bisa melihat probability survive untuk seseorang berdasarkan
jenis kelamin DAN kelas mereka. Data ini akan disimpan di data frame bernama
prob_survive. Melihat data frame tersebut kita dengan jelas mendapatkan info
bahwa untuk semua gender, pria dan wanita, memang kemungkinan selamat menurun
semakin menurunnya kelas. Dengan demikian memang ada perlakuan khusus terhadap
penumpang kelas atas pada saat proses evakuasi.

Hebat! Titanic tenggelam pada tahun 1912 tapi sekarang pun di tahun 2021 kita
bisa mendapatkan kebenaran mengenai proses evakuasi Titanic hanya dengan data!

Sebenernya masih bisa lagi kita lanjut analisa ini. Cabin number belom disentuh.
Bisa jdi cabin number mempengaruhi kemungkinan selamat seseorang. Tapi masalahnya
adalah cabin number ini jauh lebih banyak yang tidak diketahui daripada yang
diketahui. dari 891 penumpang, 687 tidak diketahui nomor kabinnya. Hanya 204,
yaitu 22.8% nya saja yang kita tau.

Kolom embark juga belum di explore, bisa jadi ada semacam pola dimana dari
salah satu pelabuhan ternyata banyak bgt penumpang kelas 3 yang dateng karena
itu pelabuhan miskin dan emang pergi kesana buat ambil pekerja. Bisa jadi ada
pelabuhan dimana banyak orang kelas 1 masuk darisana karena emang itu daerah
orang kaya dan penumpang titanic pada kesana semua sambil nunggu kapalnya dtg.

Fuck ini ternyata ada data tambahan sebanyak 419 orang di file lain. Gw nggak
tau sama sekali kenapa data ini dipisah. Nice banget sekarang gw harus mulai
analisa dari awal. Dari sini gw belajar bahwa gw harus catet script apa aja yg
gw pake just in case ada kasus kayak begini atau gw mau kasih orang lain scirpt
nya supaya analisanya bisa di replicate.

By the way ada yang aneh deh. di data yang test.csv itu nggak ada kolom survive
artinya kita nggak tau ini 419 orang survive atau tidak? Begitu?

Oh bukan. data train itu digunakan untuk melatih algoritma machine learning.
Tujuannya adalah untuk melatih algonya dan digunakan untuk memprediksi apakah
penumpang di data selanjutnya bakalan survive atau tidak. Katanya sih ini masih
basic banget untuk Machine Learning. Tapi gw sekarang belum bisa ML. Nanti deh
belajar dulu aja yg masih basic. Nanti klo udh selesai baru balik lagi kesini.
"""