/*
    SPDX-FileCopyrightText: 2020 Jonathan Poelen <jonathan.poelen@gmail.com>

    SPDX-License-Identifier: MIT
*/

#ifndef KSYNTAXHIGHLIGHTING_ANSIHIGHLIGHTER_H
#define KSYNTAXHIGHLIGHTING_ANSIHIGHLIGHTER_H

#include "abstracthighlighter.h"
#include "ksyntaxhighlighting_export.h"

#include <QFlags>
#include <QString>

QT_BEGIN_NAMESPACE
class QIODevice;
QT_END_NAMESPACE

namespace KSyntaxHighlighting
{
class AnsiHighlighterPrivate;

// Exported for a bundled helper program
class KSYNTAXHIGHLIGHTING_EXPORT AnsiHighlighter final : public AbstractHighlighter
{
public:
    enum class AnsiFormat {
        TrueColor,
        XTerm256Color,
    };

    enum class TraceOption {
        NoOptions,
        Format = 1 << 0,
        Region = 1 << 1,
        Context = 1 << 2,
        StackSize = 1 << 3,
    };
    Q_DECLARE_FLAGS(TraceOptions, TraceOption)

    AnsiHighlighter();
    ~AnsiHighlighter() override;

    void highlightFile(const QString &fileName,
                       AnsiFormat format = AnsiFormat::TrueColor,
                       bool useEditorBackground = true,
                       TraceOptions traceOptions = TraceOptions());
    void
    highlightData(QIODevice *device, AnsiFormat format = AnsiFormat::TrueColor, bool useEditorBackground = true, TraceOptions traceOptions = TraceOptions());

    void setOutputFile(const QString &fileName);
    void setOutputFile(FILE *fileHandle);

protected:
    void applyFormat(int offset, int length, const Format &format) override;

private:
    Q_DECLARE_PRIVATE(AnsiHighlighter)
};
}

Q_DECLARE_OPERATORS_FOR_FLAGS(KSyntaxHighlighting::AnsiHighlighter::TraceOptions)

#endif // KSYNTAXHIGHLIGHTING_ANSIHIGHLIGHTER_H
