class CreatePortofolioRequest {
  int jumlah_beli;
  int pk;

  CreatePortofolioRequest({
    required this.jumlah_beli,
    required this.pk,
  });

  Map<String, dynamic> toJson() => {
        "jumlah_beli": jumlah_beli,
        "pk": pk,
      };
}
