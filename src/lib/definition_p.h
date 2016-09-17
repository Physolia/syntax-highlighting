/*
    Copyright (C) 2016 Volker Krause <vkrause@kde.org>

    This program is free software; you can redistribute it and/or modify it
    under the terms of the GNU Library General Public License as published by
    the Free Software Foundation; either version 2 of the License, or (at your
    option) any later version.

    This program is distributed in the hope that it will be useful, but WITHOUT
    ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
    FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Library General Public
    License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

#ifndef SYNTAXHIGHLIGHTING_DEFINITION_P_H
#define SYNTAXHIGHLIGHTING_DEFINITION_P_H

#include <QHash>
#include <QString>
#include <QVector>

QT_BEGIN_NAMESPACE
class QXmlStreamReader;
QT_END_NAMESPACE

namespace SyntaxHighlighting {

class Definition;
class Repository;

class DefinitionData
{
public:
    DefinitionData();
    ~DefinitionData();

    static DefinitionData* get(const Definition &def);

    bool isLoaded() const;
    bool loadLanguage(QXmlStreamReader &reader);
    void loadHighlighting(Definition *def, QXmlStreamReader &reader);
    void loadContexts(Definition *def, QXmlStreamReader &reader);
    void loadItemData(QXmlStreamReader &reader);
    void loadGeneral(QXmlStreamReader &reader);
    bool checkKateVersion(const QStringRef &verStr);

    Repository *repo;
    QHash<QString, KeywordList> keywordLists;
    QVector<Context*> contexts;
    QHash<QString, Format> formats;
    QString delimiters;

    QString fileName;
    QString name;
    QString section;
    QString style;
    QString indenter;
    QString author;
    QString license;
    QVector<QString> mimetypes;
    QVector<QString> extensions;
    Qt::CaseSensitivity caseSensitive;
    float version;
    int priority;
    bool hidden;
};
}

#endif
