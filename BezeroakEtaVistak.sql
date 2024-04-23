
-- Erabiltzaileak, bere rolak eta bere baimenak

use db_jpamt7;

-- Rolak
CREATE ROLE IF NOT EXISTS dbAdmin, dbDepartBurua, dbAnalista, dbLangileak, dbBezeroa;

-- Bistak
-- Podcast eta abestiaren datu interesgarriak irazkutzeko (izena, album izena, artista eta iraupena)
CREATE OR REPLACE VIEW AbestiInformazioa
AS 
SELECT audio.izena as "Abesti izena", album.izenburua as "Izenburua", musikaria.IzenArtistikoa as "Artista izena", audio.Iraupena as "Iraupena"
	FROM abestia JOIN audio using (IdAudio)
				JOIN album USING (IdAlbum)
                JOIN musikaria USING (IDMusikaria);
                
CREATE OR REPLACE VIEW PodcastInformazioa
AS 
SELECT audio.izena as "Izena", podcast.Kolaboratzaileak as "Kolaboratzaileak", podcaster.IzenArtistikoa as "Artista", audio.Iraupena as "Iraupena"
	FROM podcast JOIN audio using (IdAudio)
                JOIN podcaster USING (IDPodcaster);
                
-- Zenbat bezero eta horietako zeinek PREMIUM ordaintzen dute 
CREATE OR REPLACE VIEW BezeroEtaPremiumKopurua
AS
SELECT count(bezeroa.IDBezeroa) as "Bezero Kopurua", count(premium.IDBezeroa) as "Premium Kantitatea"
	FROM bezeroa LEFT JOIN premium using(IDBezeroa);

-- Baimenak
REPAIR TABLE db_jpamt7;
GRANT ALL PRIVILEGES ON *.* TO dbAdmin;

GRANT SELECT, UPDATE ON db_jpamt7.audio to dbDepartBurua;
GRANT SELECT, UPDATE ON db_jpamt7.musikaria to dbDepartBurua;
GRANT SELECT, UPDATE ON db_jpamt7.podcast to dbDepartBurua;
GRANT SELECT, UPDATE ON db_jpamt7.album to dbDepartBurua;
GRANT SELECT ON db_jpamt7.podcaster to dbDepartBurua;
GRANT SELECT ON db_jpamt7.bezeroa to dbDepartBurua;
GRANT SELECT ON db_jpamt7.erreprodukzioak to dbDepartBurua;
GRANT SELECT ON db_jpamt7.estatisktikak to dbDepartBurua;

-- Analisten baimenak
GRANT SELECT ON db_jpamt7.musikaria to dbAnalista;
GRANT SELECT ON db_jpamt7.audio to dbAnalista;
GRANT SELECT ON db_jpamt7.podcaster to dbAnalista;
GRANT SELECT ON db_jpamt7.podcast to dbAnalista;
GRANT SELECT ON db_jpamt7.bezeroa to dbAnalista;
GRANT SELECT ON db_jpamt7.album to dbAnalista;
GRANT SELECT ON db_jpamt7.BezeroEtaPremiumKopurua to dbAnalista;
GRANT SELECT ON db_jpamt7.erreprodukzioak to dbAnalista;
GRANT SELECT ON db_jpamt7.estatisktikak to dbAnalista;

-- Langileen baimenak
GRANT SELECT, UPDATE ON db_jpamt7.musikaria to dbLangileak;
GRANT SELECT, UPDATE ON db_jpamt7.podcaster to dbLangileak;
GRANT SELECT, UPDATE ON db_jpamt7.podcast to dbLangileak;
GRANT SELECT, UPDATE ON db_jpamt7.audio to dbLangileak;
GRANT SELECT, UPDATE ON db_jpamt7.album to dbLangileak;
GRANT SELECT, UPDATE ON db_jpamt7.bezeroa to dbLangileak;
GRANT SELECT ON db_jpamt7.AbestiInformazioa to dbLangileak;
GRANT SELECT ON db_jpamt7.PodcastInformazioa to dbLangileak;
GRANT SELECT ON db_jpamt7.erreprodukzioak to dbLangileak;
GRANT SELECT ON db_jpamt7.estatisktikak to dbLangileak;

-- Bezeroen baimenak
GRANT SELECT, INSERT ON db_jpamt7.gustukoak to dbBezeroa;
GRANT SELECT, INSERT ON db_jpamt7.playlist to dbBezeroa;
GRANT SELECT, INSERT ON db_jpamt7.playlist_abestiak to dbBezeroa;
GRANT SELECT ON db_jpamt7.AbestiInformazioa to dbBezeroa;
GRANT SELECT ON db_jpamt7.PodcastInformazioa to dbBezeroa;
GRANT INSERT ON db_jpamt7.bezeroa to dbBezeroa;

-- Erabiltzaileak
CREATE USER IF NOT EXISTS administrador@localhost IDENTIFIED BY "admin";
CREATE USER IF NOT EXISTS eider@localhost IDENTIFIED BY "hoStiongrEl";
CREATE USER IF NOT EXISTS jon@localhost IDENTIFIED BY "ArHelIblEiv";
CREATE USER IF NOT EXISTS ane@localhost IDENTIFIED BY "ODenTantrAI";
CREATE USER IF NOT EXISTS markel@localhost IDENTIFIED BY "aMPEnIDsUrn";
CREATE USER IF NOT EXISTS aimar@localhost IDENTIFIED BY "ORANGE";

GRANT dbAdmin TO administrador@localhost;
GRANT dbDepartBurua TO eider@localhost;
GRANT dbAnalista TO jon@localhost;
GRANT dbAnalista TO ane@localhost;
GRANT dbLangileak TO markel@localhost;
GRANT dbBezeroa TO aimar@localhost;

