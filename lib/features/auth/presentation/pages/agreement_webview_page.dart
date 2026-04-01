import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../models/agreement_document.dart';

class AgreementWebViewPage extends StatefulWidget {
  const AgreementWebViewPage({super.key, required this.document});

  final AgreementDocument document;

  @override
  State<AgreementWebViewPage> createState() => _AgreementWebViewPageState();
}

class _AgreementWebViewPageState extends State<AgreementWebViewPage> {
  late final WebViewController _controller;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) {
            if (!mounted) {
              return;
            }

            setState(() {
              _isLoading = true;
              _errorMessage = null;
            });
          },
          onPageFinished: (_) {
            if (!mounted) {
              return;
            }

            setState(() {
              _isLoading = false;
            });
          },
          onWebResourceError: (error) {
            if (!mounted) {
              return;
            }

            setState(() {
              _isLoading = false;
              _errorMessage = '문서를 불러오지 못했습니다. 잠시 후 다시 시도해주세요.';
            });
          },
        ),
      )
      ..loadRequest(widget.document.uri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: -80,
              left: 0,
              right: 0,
              bottom: 0,
              child: WebViewWidget(controller: _controller),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: IconButton(
                onPressed: () => context.pop(),
                icon: const Icon(Icons.close),
              ),
            ),
            if (_errorMessage != null)
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    _errorMessage!,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
            if (_isLoading) const Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }
}
