#include "cppmodel.hpp"
#include <mxnetpredict.hpp>

//
// Implementation
//

CppModel::CppModel(MXNetPredict p): predictor(p), m_thumbnailSrc("qrc:/images/connected.png"), m_labels(QStringList()), loading(true) {}

// Properties

void CppModel::setThumbnailSrc(const QString &a) {
    if (a != m_thumbnailSrc) {
        QString aCopy(a);
        aCopy.remove(0, 8);

        this->m_thumbnailSrc = a;
        emit thumbnailSrcChanged();

        MyImage im;
        auto im_data = im.processImage(aCopy);
        auto labels = this->predictor.getPredictions(im_data, 5);

        this->m_labels.clear();

        for (int i = 0; i < static_cast<int> (labels.size()); i++ ){
            auto x = labels[i];
            float p = x.first;
            QString l = x.second;
            this->m_labels.append(QString("(%1) - %2").arg(QString::number(p, 'g', 2)).arg(l));
        }

        emit labelsChanged();
    }
}
