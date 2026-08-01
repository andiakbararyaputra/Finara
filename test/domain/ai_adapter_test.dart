import 'package:finara/domain/ai/ai_models.dart';
import 'package:finara/domain/ai/data_sanitizer.dart';
import 'package:finara/domain/ai/financial_context_builder.dart';
import 'package:finara/domain/ai/mock_ai_adapter.dart';
import 'package:finara/domain/ai/openai_compatible_adapter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const config = AIProviderConfig(baseUrl: 'https://api.contoh.test/v1');
  final adapter = OpenAICompatibleAdapter(config);

  group('OpenAICompatibleAdapter — buildRequest', () {
    test('body minimal tanpa parameter opsional', () {
      final body = adapter.buildRequest(const AIChatRequest(
        model: 'gpt-x',
        messages: [AIMessage(role: AIRole.user, content: 'Halo')],
      ));
      expect(body, {
        'model': 'gpt-x',
        'messages': [
          {'role': 'user', 'content': 'Halo'},
        ],
      });
    });

    test('parameter opsional + stream ikut terkirim', () {
      final body = adapter.buildRequest(const AIChatRequest(
        model: 'gpt-x',
        messages: [AIMessage(role: AIRole.system, content: 'S')],
        temperature: 0.3,
        maxOutputTokens: 512,
        stream: true,
      ));
      expect(body['temperature'], 0.3);
      expect(body['max_tokens'], 512);
      expect(body['stream'], isTrue);
    });
  });

  group('OpenAICompatibleAdapter — parseResponse', () {
    test('mengambil konten choice pertama', () {
      final hasil = adapter.parseResponse({
        'model': 'gpt-x',
        'choices': [
          {
            'message': {'role': 'assistant', 'content': 'Terhubung.'},
          },
        ],
      });
      expect(hasil.content, 'Terhubung.');
      expect(hasil.model, 'gpt-x');
    });

    test('choices kosong → responsKosong', () {
      expect(
        () => adapter.parseResponse({'choices': <Object>[]}),
        throwsA(isA<AIProviderException>().having(
            (e) => e.kind, 'kind', AIErrorKind.responsKosong)),
      );
    });
  });

  group('OpenAICompatibleAdapter — parseSseLine', () {
    test('baris data berisi delta konten', () {
      const baris =
          'data: {"choices":[{"delta":{"content":"Ha"}}]}';
      expect(OpenAICompatibleAdapter.parseSseLine(baris), 'Ha');
    });

    test('[DONE] dan baris non-data', () {
      expect(OpenAICompatibleAdapter.parseSseLine('data: [DONE]'), '');
      expect(OpenAICompatibleAdapter.parseSseLine(': komentar'), isNull);
      expect(OpenAICompatibleAdapter.parseSseLine(''), isNull);
    });

    test('payload rusak tidak melempar', () {
      expect(OpenAICompatibleAdapter.parseSseLine('data: {rusak'), '');
    });
  });

  group('OpenAICompatibleAdapter — parseError (§48)', () {
    test('pemetaan status ke jenis error', () {
      expect(adapter.parseError(401, '{}').kind, AIErrorKind.apiKeyDitolak);
      expect(adapter.parseError(404, '{"error":{"message":"model x not found"}}').kind,
          AIErrorKind.modelTidakTersedia);
      expect(adapter.parseError(404, '{}').kind, AIErrorKind.endpointSalah);
      expect(adapter.parseError(429, '{"error":{"message":"quota exceeded"}}').kind,
          AIErrorKind.kuotaHabis);
      expect(adapter.parseError(429, '{}').kind, AIErrorKind.rateLimit);
      expect(adapter.parseError(503, '{}').kind, AIErrorKind.modelOverload);
      expect(adapter.parseError(413, '{}').kind,
          AIErrorKind.konteksTerlaluPanjang);
    });

    test('detail error tidak memuat kredensial', () {
      final err = adapter.parseError(
          401, '{"error":{"message":"invalid key"}}');
      expect(err.detail.contains('Bearer'), isFalse);
      expect(err.detail, contains('HTTP 401'));
    });
  });

  group('MockAIAdapter', () {
    test('sendMessage & streamMessage menghasilkan jawaban penuh', () async {
      final mock = MockAIAdapter(jawaban: 'Halo dari mock');
      final respons = await mock.sendMessage(
        const AIChatRequest(model: 'mock-mini', messages: []),
        apiKey: 'x',
      );
      expect(respons.content, 'Halo dari mock');

      final potongan = await mock
          .streamMessage(
              const AIChatRequest(model: 'mock-mini', messages: []),
              apiKey: 'x')
          .join();
      expect(potongan.trim(), 'Halo dari mock');
      expect(mock.requestLog, hasLength(2));
    });

    test('errorKind menyebabkan semua operasi gagal', () async {
      final mock = MockAIAdapter(errorKind: AIErrorKind.rateLimit);
      expect(
        () => mock.fetchModels(apiKey: 'x'),
        throwsA(isA<AIProviderException>()
            .having((e) => e.kind, 'kind', AIErrorKind.rateLimit)),
      );
    });
  });

  group('DataSanitizer (§45)', () {
    const sanitizer = DataSanitizer();

    test('membuang API key, bearer, dan kredensial', () {
      expect(sanitizer.bersihkan('kunci sk-abc123XYZ890 bocor'),
          isNot(contains('sk-abc123XYZ890')));
      expect(sanitizer.bersihkan('Authorization: Bearer rahasia123'),
          isNot(contains('rahasia123')));
      expect(sanitizer.bersihkan('PIN: 123456'), isNot(contains('123456')));
      expect(sanitizer.bersihkan('kartu 4111111111111111'),
          isNot(contains('4111111111111111')));
    });

    test('teks keuangan normal tidak berubah', () {
      const teks = 'Total Pendapatan: Rp10.000.000 (40% dari Dana Bersih)';
      expect(sanitizer.bersihkan(teks), teks);
    });
  });

  group('FinancialContextBuilder (§43)', () {
    test('konteks memuat nilai rencana berlabel dan tersanitasi', () {
      const builder = FinancialContextBuilder();
      final teks = builder.bangunKonteksAlokasi(
        tahun: 2026,
        bulan: 8,
        totalPendapatan: 10000000,
        kasPeganganBrimo: 300000,
        totalPengeluaranWajib: 1500000,
        totalDanaMasukJago: 4780000,
        danaBersih: 8200000,
        alokasiJago: 3280000,
        totalAlokasiInvestasi: 2460000,
        alokasiBibit: 1722000,
        alokasiStockbit: 738000,
        alokasiDana: 2460000,
        subJagoLangganan: 328000,
        subJagoDanaDarurat: 1640000,
        subJagoOperasional: 1312000,
        namaPreset: 'standardHybrid',
      );
      expect(teks, contains('RENCANA'));
      expect(teks, contains('Rp10.000.000'));
      expect(teks, contains('Alokasi Bibit: Rp1.722.000 (70%'));
      expect(teks, contains('30% dari Total Alokasi Investasi'));
      expect(teks, contains('bulan 8/2026'));
    });

    test('system prompt sesuai §46', () {
      expect(FinancialContextBuilder.systemPrompt,
          contains('Anda adalah Finara AI'));
      expect(FinancialContextBuilder.systemPrompt,
          contains('bukan nasihat keuangan profesional'));
    });
  });
}
