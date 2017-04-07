#ifndef CPPMODEL_HPP
#define CPPMODEL_HPP

#include <QObject>
#include <QString>
#include <vector>

#include <mxnetpredict.hpp>
#include <mxnetimage.hpp>

class CppModel : public QObject {
    Q_OBJECT
    Q_PROPERTY(QString thumbnailSrc READ thumbnailSrc WRITE setThumbnailSrc NOTIFY thumbnailSrcChanged)
    Q_PROPERTY(QStringList labels READ labels NOTIFY labelsChanged)
public:
    CppModel(MXNetPredict p);

    // Properties
    void setThumbnailSrc(const QString &a);
    QString thumbnailSrc() const {
        return this->m_thumbnailSrc;
    }
    QStringList labels() const {
        return this->m_labels;
    }
signals:
    void thumbnailSrcChanged();
    void labelsChanged();
private:
    bool loading;
    QString m_thumbnailSrc;
    QStringList m_labels;
    MXNetPredict predictor;
};

#endif // CPPMODEL_HPP
