# 🌐 FogyHub — MM2 Multi-Tool

<p align="center">
  <img src="https://img.shields.io/badge/Roblox-MM2-red?style=for-the-badge&logo=roblox&logoColor=white" />
  <img src="https://img.shields.io/badge/Language-English%20%7C%20Russian-blue?style=for-the-badge" />
  <img src="https://img.shields.io/badge/Authors-MsD%20%26%20Gemini-green?style=for-the-badge" />
</p>

**FogyHub** is a clean, multi-functional, and highly optimized script for Roblox Murder Mystery 2. Featuring professional on-screen customization, dynamic translations, traffic-saving music streaming, and solid FE-compatible combat, it is designed for both PC and mobile executors.

---

> [!WARNING]
> **Compatibility Notice / Предупреждение о совместимости**
> 
> **[EN]** This script uses Roblox's native `Highlight` instances for the ESP system. 
> * **PC Executors:** Lightweight or low-UNC executors (such as **Solara**, **Celery**, etc.) may experience client freezes or immediate crashes when rendering these outlines.
> * **Mobile Executors:** Mobile tools (such as **Delta**, **Codex**, **Arceus X**, etc.) can lag heavily or crash due to GPU overhead from highlights.
> * *If you experience crashes or severe frame drops, please keep ESP disabled and use **3D Box ESP** instead.*
> 
> **[RU]** Этот скрипт использует стандартные объекты `Highlight` для работы ESP.
> * **ПК инжекторы:** Легковесные утилиты с низким уровнем UNC (такие как **Solara**, **Celery** и др.) могут зависать или вызывать мгновенный вылет клиента при отрисовке контуров.
> * **Мобильные инжекторы:** Мобильные читы (такие как **Delta**, **Codex**, **Arceus X** и др.) могут сильно лагать или вылетать из-за высокой нагрузки на графический чип телефона.
> * *Если вы сталкиваетесь с вылетами или падением FPS, пожалуйста, отключите ESP и используйте **3D Бокс ESP**.*

---

## 📜 Features Description / Описание функций

### 👁️ Visuals / Визуалы
* **ESP Highlights & 3D Boxes (ESP Силуэты и 3D Боксы):**
  * **[EN]** Outlines Murderers (Red), Sheriffs (Blue), and Innocents (Green). Features high-performance 3D Bounding Boxes as a safe, lag-free fallback for lower-end executors.
  * **[RU]** Подсвечивает Убийц (Красный), Шерифов (Синий) и Мирных жителей (Зеленый). Включает аппаратные 3D-боксы, которые гарантируют стабильную работу на любых слабых утилитах.
* **Screen Stretch (Растяг экрана):**
  * **[EN]** Emulates a stretched 4:3 resolution smoothly without screen tearing or standard distortion.
  * **[RU]** Плавно эмулирует растянутое разрешение экрана 4:3 без искажений интерфейса и разрывов изображения.
* **Custom Skyboxes & Lighting (Смена неба и Освещение):**
  * **[EN]** Instantly replace skyboxes with Space Nebula, Sunset, or default textures. Includes options to disable map fog (No Fog) and custom Time of Day.
  * **[RU]** Позволяет менять небо на Космическую туманность, красивый Закат или возвращать стандартное. Убирает туман на карте и настраивает время суток.

### ⚔️ Combat / Бой
* **Auto-Shoot Murderer (Авто-выстрел):**
  * **[EN]** Automatically aims and fires the revolver at the murderer once equipped, using direct packet emulation and physical click backups.
  * **[RU]** Автоматически наводится и стреляет в убийцу по сети при взятии пистолета в руку, дублируя нажатия физическими кликами.
* **Aimlock on Murderer (Аимлок):**
  * **[EN]** Smoothly locks your camera directly onto the murderer's head.
  * **[RU]** Плавно удерживает камеру сфокусированной на голове убийцы.
* **TP Behind & Shoot (ТП за спину и выстрел):**
  * **[EN]** Instantly teleports behind the murderer, freezes you in the air if they are jumping to ensure a clean shot, fires, and safely returns you back.
  * **[RU]** Моментально переносит за спину убийцы, временно блокирует физику падения в воздухе для точного выстрела и возвращает вас обратно на землю.
* **Auto-Dodge Knife (Авто-Манс):**
  * **[EN]** Automatically detects thrown knives (`ThrownKnife`) and performs a rapid sideways dodge to the right to bypass the knife's hitbox.
  * **[RU]** Отслеживает летящие ножи и делает мгновенный уклоняющий отпрыг вправо при опасном приближении.
* **Kill Aura & Auto Kill All (Килаура и Убить всех):**
  * **[EN]** Instantly kills everyone within a configurable range without contact using physical touch emulation, or teleports to every single player to wipe the server.
  * **[RU]** Автоматически наносит урон ножом всем игрокам в радиусе без прямого контакта, либо поочередно уничтожает каждого выжившего на сервере.
* **Fling Murderer / Sheriff (Флинг):**
  * **[EN]** Launches the targeted player into the void using advanced physical recoil.
  * **[RU]** Отправляет выбранную цель в бесконечный полет в бездну с помощью физического толчка.

### ⚡ Utility / Утилиты
* **Auto Grab Gun (Автоподбор пистолета):**
  * **[EN]** Safely teleports you to the dropped gun, disables collision, temporarily unanchors your character to trigger the pick-up event, and safely returns you to your origin.
  * **[RU]** Безопасно переносит вас к пистолету, убирает коллизию и плавно опускает персонажа под землю, временно отключая анкор для гарантированного подбора.
* **Infinite Speed Glitch (Спидглитч бега):**
  * **[EN]** Smoothly offsets your CFrame to run at extreme speeds without changing your WalkSpeed. Keeps running animations at normal speed (undetectable).
  * **[RU]** Ускоряет ваше перемещение CFrame-смещением по горизонтали, оставляя анимацию ходьбы на 100% стандартной скорости (бесшумный бег).
* **Noclip & Anti-Fling (Ноуклип и Анти-Флинг):**
  * **[EN]** Walk through walls, and protect yourself from physics exploits used by other players trying to spin or fling you.
  * **[RU]** Проходите сквозь любые препятствия и защищайте себя от попыток закрутить или выбить вашего персонажа из карты.

### 📌 Mobile Buttons / Мобильные Кнопки
* **[EN]** Create individual floating touch shortcuts for your favorite functions, drag them anywhere with mobile-optimized touch-drag, lock them in place, and scale their sizes in real-time.
* **[RU]** Создавайте независимые экранные кнопки для любимых функций, свободно перетаскивайте их пальцем, фиксируйте положение и настраивайте масштаб прямо в процессе игры.

### 🎵 HTTP Radio / Радио
* **[EN]** Play songs using standard Roblox Audio IDs, or stream any external MP3/OGG song directly via an HTTP URL. Includes smart traffic-saving caching.
* **[RU]** Проигрывайте музыку по Roblox ID или скачивайте внешние mp3/ogg файлы по прямым ссылкам. Повторная загрузка отменяется благодаря локальному кэшу.

---

## 🚀 How to Execute / Инструкция по запуску

```lua
-- FogyHub (MsD & Gemini)
loadstring(game:HttpGet("https://raw.githubusercontent.com/NeMsd/FogyHub/refs/heads/main/main.lua"))()
