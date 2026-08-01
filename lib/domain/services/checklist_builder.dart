/// Checklist transfer rencana awal (§21): dibuat dinamis dari hasil alokasi
/// dan kanal pembayaran pengeluaran wajib. Kode dipetakan ke ARB di UI.
library;

import '../models/allocation_input.dart';
import '../models/allocation_result.dart';

class ChecklistTemplateItem {
  const ChecklistTemplateItem(this.kode, {this.nominal, this.detail});

  final String kode;
  final int? nominal;
  final String? detail;
}

class ChecklistBuilder {
  const ChecklistBuilder();

  List<ChecklistTemplateItem> buat(
    AllocationInput input,
    AllocationResult hasil,
  ) {
    final items = <ChecklistTemplateItem>[
      ChecklistTemplateItem('sisakanKasPegangan',
          nominal: hasil.kasPeganganBrimo),
      ChecklistTemplateItem('transferDanaMasukJago',
          nominal: hasil.totalDanaMasukJago),
      ChecklistTemplateItem('pisahkanKantongWajib',
          nominal: hasil.totalPengeluaranWajib),
      ChecklistTemplateItem('pisahkanAlokasiJago', nominal: hasil.alokasiJago),
    ];

    final sub = hasil.subAlokasiJago;
    if (sub.kebutuhanLangganan > 0) {
      items.add(ChecklistTemplateItem('isiKantongLangganan',
          nominal: sub.kebutuhanLangganan));
    }
    if (sub.danaDarurat > 0) {
      items.add(ChecklistTemplateItem('isiKantongDanaDarurat',
          nominal: sub.danaDarurat));
    }
    if (sub.danaOperasional > 0) {
      items.add(ChecklistTemplateItem('isiKantongOperasional',
          nominal: sub.danaOperasional));
    }
    if (hasil.alokasiBibit > 0) {
      items.add(
          ChecklistTemplateItem('topUpBibit', nominal: hasil.alokasiBibit));
    }
    if (hasil.alokasiStockbit > 0) {
      items
        ..add(ChecklistTemplateItem('transferRdnStockbit',
            nominal: hasil.alokasiStockbit))
        ..add(const ChecklistTemplateItem('verifikasiRdnCatatTerpisah'));
    }
    if (hasil.alokasiDana > 0) {
      items.add(
          ChecklistTemplateItem('topUpDana', nominal: hasil.alokasiDana));
    }

    // Item dinamis per kanal pembayaran pengeluaran wajib non-Jago (§21).
    for (final e in input.pengeluaranWajib) {
      switch (e.kanalPembayaran) {
        case PaymentChannel.bankJago:
          break; // dibayar langsung dari Kantong Pengeluaran Wajib
        case PaymentChannel.dana:
          items.add(ChecklistTemplateItem('pindahkanWajibKeDana',
              nominal: e.nominal, detail: e.nama));
        case PaymentChannel.tunai:
          items.add(ChecklistTemplateItem('tarikWajibTunai',
              nominal: e.nominal, detail: e.nama));
        case PaymentChannel.transferBankLain:
        case PaymentChannel.lainnya:
          items.add(ChecklistTemplateItem('pindahkanWajibKeBankLain',
              nominal: e.nominal, detail: e.nama));
      }
    }

    items
      ..add(const ChecklistTemplateItem('periksaSatuSumberAnggaran'))
      ..add(const ChecklistTemplateItem('periksaPemindahanBukanPengeluaran'));

    return List.unmodifiable(items);
  }
}
