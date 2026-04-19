#pragma once

#include <QDialog>



namespace Ui { class OpenWebsiteDialog; }



class OpenWebsiteDialog : public QDialog
{
    Q_OBJECT

public:
    explicit OpenWebsiteDialog(QWidget *parent = nullptr);
    ~OpenWebsiteDialog();

private slots:
    // Tools
    void on_btn_Tools_SteamTools_clicked();
    // Manifest
    void on_btn_Manifest_Assiw_clicked();
    void on_btn_Manifest_ManifestHub_clicked();
    void on_btn_Manifest_SteamManifestHub_clicked();
    void on_btn_Manifest_SteamManifestDownloader_clicked();
    void on_btn_Manifest_SteamDownloader_clicked();
    // DataBase
    void on_btn_DataBase_SteamDB_clicked();
    void on_btn_DataBase_SteamUI_clicked();
    // Community
    void on_btn_Community_3ACommunity_clicked();
    void on_btn_Community_Caigamer_clicked();

private:
    Ui::OpenWebsiteDialog *ui;
};
