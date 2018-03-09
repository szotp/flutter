// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../rendering/mock_canvas.dart';

class TestCanvas implements Canvas {
  final List<Invocation> invocations = <Invocation>[];

  @override
  void noSuchMethod(Invocation invocation) {
    invocations.add(invocation);
  }
}

void main() {
  // the textDirection values below are intentionally sometimes different and
  // sometimes the same as the layoutDirection, to make sure that they don't
  // affect the layout.

  test('A Banner with a location of topStart paints in the top left (LTR)', () {
    final BannerPainter bannerPainter = new BannerPainter(
      message: 'foo',
      textDirection: TextDirection.rtl,
      location: BannerLocation.topStart,
      layoutDirection: TextDirection.ltr,
    );

    final TestCanvas canvas = new TestCanvas();

    bannerPainter.paint(canvas, const Size(1000.0, 1000.0));

    final Invocation translateCommand = canvas.invocations.firstWhere((Invocation invocation) {
      return invocation.memberName == #translate;
    });

    expect(translateCommand, isNotNull);
    expect(translateCommand.positionalArguments[0], lessThan(100.0));
    expect(translateCommand.positionalArguments[1], lessThan(100.0));

    final Invocation rotateCommand = canvas.invocations.firstWhere((Invocation invocation) {
      return invocation.memberName == #rotate;
    });

    expect(rotateCommand, isNotNull);
    expect(rotateCommand.positionalArguments[0], equals(-math.PI / 4.0));
  });

  test('A Banner with a location of topStart paints in the top right (RTL)', () {
    final BannerPainter bannerPainter = new BannerPainter(
      message: 'foo',
      textDirection: TextDirection.ltr,
      location: BannerLocation.topStart,
      layoutDirection: TextDirection.rtl,
    );

    final TestCanvas canvas = new TestCanvas();

    bannerPainter.paint(canvas, const Size(1000.0, 1000.0));

    final Invocation translateCommand = canvas.invocations.firstWhere((Invocation invocation) {
      return invocation.memberName == #translate;
    });

    expect(translateCommand, isNotNull);
    expect(translateCommand.positionalArguments[0], greaterThan(900.0));
    expect(translateCommand.positionalArguments[1], lessThan(100.0));

    final Invocation rotateCommand = canvas.invocations.firstWhere((Invocation invocation) {
      return invocation.memberName == #rotate;
    });

    expect(rotateCommand, isNotNull);
    expect(rotateCommand.positionalArguments[0], equals(math.PI / 4.0));
  });

  test('A Banner with a location of topEnd paints in the top right (LTR)', () {
    final BannerPainter bannerPainter = new BannerPainter(
      message: 'foo',
      textDirection: TextDirection.ltr,
      location: BannerLocation.topEnd,
      layoutDirection: TextDirection.ltr,
    );

    final TestCanvas canvas = new TestCanvas();

    bannerPainter.paint(canvas, const Size(1000.0, 1000.0));

    final Invocation translateCommand = canvas.invocations.firstWhere((Invocation invocation) {
      return invocation.memberName == #translate;
    });

    expect(translateCommand, isNotNull);
    expect(translateCommand.positionalArguments[0], greaterThan(900.0));
    expect(translateCommand.positionalArguments[1], lessThan(100.0));

    final Invocation rotateCommand = canvas.invocations.firstWhere((Invocation invocation) {
      return invocation.memberName == #rotate;
    });

    expect(rotateCommand, isNotNull);
    expect(rotateCommand.positionalArguments[0], equals(math.PI / 4.0));
  });

  test('A Banner with a location of topEnd paints in the top left (RTL)', () {
    final BannerPainter bannerPainter = new BannerPainter(
      message: 'foo',
      textDirection: TextDirection.rtl,
      location: BannerLocation.topEnd,
      layoutDirection: TextDirection.rtl,
    );

    final TestCanvas canvas = new TestCanvas();

    bannerPainter.paint(canvas, const Size(1000.0, 1000.0));

    final Invocation translateCommand = canvas.invocations.firstWhere((Invocation invocation) {
      return invocation.memberName == #translate;
    });

    expect(translateCommand, isNotNull);
    expect(translateCommand.positionalArguments[0], lessThan(100.0));
    expect(translateCommand.positionalArguments[1], lessThan(100.0));

    final Invocation rotateCommand = canvas.invocations.firstWhere((Invocation invocation) {
      return invocation.memberName == #rotate;
    });

    expect(rotateCommand, isNotNull);
    expect(rotateCommand.positionalArguments[0], equals(-math.PI / 4.0));
  });

  test('A Banner with a location of bottomStart paints in the bottom left (LTR)', () {
    final BannerPainter bannerPainter = new BannerPainter(
      message: 'foo',
      textDirection: TextDirection.ltr,
      location: BannerLocation.bottomStart,
      layoutDirection: TextDirection.ltr,
    );

    final TestCanvas canvas = new TestCanvas();

    bannerPainter.paint(canvas, const Size(1000.0, 1000.0));

    final Invocation translateCommand = canvas.invocations.firstWhere((Invocation invocation) {
      return invocation.memberName == #translate;
    });

    expect(translateCommand, isNotNull);
    expect(translateCommand.positionalArguments[0], lessThan(100.0));
    expect(translateCommand.positionalArguments[1], greaterThan(900.0));

    final Invocation rotateCommand = canvas.invocations.firstWhere((Invocation invocation) {
      return invocation.memberName == #rotate;
    });

    expect(rotateCommand, isNotNull);
    expect(rotateCommand.positionalArguments[0], equals(math.PI / 4.0));
  });

  test('A Banner with a location of bottomStart paints in the bottom right (RTL)', () {
    final BannerPainter bannerPainter = new BannerPainter(
      message: 'foo',
      textDirection: TextDirection.rtl,
      location: BannerLocation.bottomStart,
      layoutDirection: TextDirection.rtl,
    );

    final TestCanvas canvas = new TestCanvas();

    bannerPainter.paint(canvas, const Size(1000.0, 1000.0));

    final Invocation translateCommand = canvas.invocations.firstWhere((Invocation invocation) {
      return invocation.memberName == #translate;
    });

    expect(translateCommand, isNotNull);
    expect(translateCommand.positionalArguments[0], greaterThan(900.0));
    expect(translateCommand.positionalArguments[1], greaterThan(900.0));

    final Invocation rotateCommand = canvas.invocations.firstWhere((Invocation invocation) {
      return invocation.memberName == #rotate;
    });

    expect(rotateCommand, isNotNull);
    expect(rotateCommand.positionalArguments[0], equals(-math.PI / 4.0));
  });

  test('A Banner with a location of bottomEnd paints in the bottom right (LTR)', () {
    final BannerPainter bannerPainter = new BannerPainter(
      message: 'foo',
      textDirection: TextDirection.rtl,
      location: BannerLocation.bottomEnd,
      layoutDirection: TextDirection.ltr,
    );

    final TestCanvas canvas = new TestCanvas();

    bannerPainter.paint(canvas, const Size(1000.0, 1000.0));

    final Invocation translateCommand = canvas.invocations.firstWhere((Invocation invocation) {
      return invocation.memberName == #translate;
    });

    expect(translateCommand, isNotNull);
    expect(translateCommand.positionalArguments[0], greaterThan(900.0));
    expect(translateCommand.positionalArguments[1], greaterThan(900.0));

    final Invocation rotateCommand = canvas.invocations.firstWhere((Invocation invocation) {
      return invocation.memberName == #rotate;
    });

    expect(rotateCommand, isNotNull);
    expect(rotateCommand.positionalArguments[0], equals(-math.PI / 4.0));
  });

  test('A Banner with a location of bottomEnd paints in the bottom left (RTL)', () {
    final BannerPainter bannerPainter = new BannerPainter(
      message: 'foo',
      textDirection: TextDirection.ltr,
      location: BannerLocation.bottomEnd,
      layoutDirection: TextDirection.rtl,
    );

    final TestCanvas canvas = new TestCanvas();

    bannerPainter.paint(canvas, const Size(1000.0, 1000.0));

    final Invocation translateCommand = canvas.invocations.firstWhere((Invocation invocation) {
      return invocation.memberName == #translate;
    });

    expect(translateCommand, isNotNull);
    expect(translateCommand.positionalArguments[0], lessThan(100.0));
    expect(translateCommand.positionalArguments[1], greaterThan(900.0));

    final Invocation rotateCommand = canvas.invocations.firstWhere((Invocation invocation) {
      return invocation.memberName == #rotate;
    });

    expect(rotateCommand, isNotNull);
    expect(rotateCommand.positionalArguments[0], equals(math.PI / 4.0));
  });

  testWidgets('Banner widget', (WidgetTester tester) async {
    await tester.pumpWidget(
      const Directionality(
        textDirection: TextDirection.ltr,
        child: const Banner(message: 'Hello', location: BannerLocation.topEnd),
      ),
    );
    expect(find.byType(CustomPaint), paints
      ..save
      ..translate(x: 800.0, y: 0.0)
      ..rotate(angle: math.PI / 4.0)
      ..rect(rect: new Rect.fromLTRB(-40.0, 28.0, 40.0, 40.0), color: const Color(0x7f000000), hasMaskFilter: true)
      ..rect(rect: new Rect.fromLTRB(-40.0, 28.0, 40.0, 40.0), color: const Color(0xa0b71c1c), hasMaskFilter: false)
      ..paragraph(offset: const Offset(-40.0, 29.0))
      ..restore
    );
  });

  testWidgets('Banner widget in MaterialApp', (WidgetTester tester) async {
    await tester.pumpWidget(new MaterialApp(home: const Placeholder()));
    expect(find.byType(CheckedModeBanner), paints
      ..save
      ..translate(x: 800.0, y: 0.0)
      ..rotate(angle: math.PI / 4.0)
      ..rect(rect: new Rect.fromLTRB(-40.0, 28.0, 40.0, 40.0), color: const Color(0x7f000000), hasMaskFilter: true)
      ..rect(rect: new Rect.fromLTRB(-40.0, 28.0, 40.0, 40.0), color: const Color(0xa0b71c1c), hasMaskFilter: false)
      ..paragraph(offset: const Offset(-40.0, 29.0))
      ..restore
    );
  });
}
