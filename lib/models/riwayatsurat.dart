class RiwayatSurat {
  String? idSurat;
  String? namaSurat;
  String? status;

  RiwayatSurat({this.idSurat, this.namaSurat, this.status});
  RiwayatSurat.fromJson(Map json)
      : idSurat = json['id_permohon'],
        namaSurat = json['nama_surat'],
        status = json['setatus'];
}
