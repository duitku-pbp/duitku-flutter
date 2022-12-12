class CreatePortofolioRequest {
  int jumlahBeli;
  int pk;

  CreatePortofolioRequest({
    required this.jumlahBeli,
    required this.pk,
  });

  Map<String, dynamic> toJson() => {
        "jumlah_beli": jumlahBeli,
        "pk": pk,
      };
}
