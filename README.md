# Vides uzstādīšana
Šo projektu var arī uzstādīt izmantojot GitHub Codespace, tam domāta mape .devcontainer. Izmantojot codespace joprojām jāizveido datubāze, kā norādīts zemāk (paralēli tam nedrīkst notikt nekādi citi procesi t.i. servera darbība, procesi konsolē).

## Lai uzstādītu projektu lokāli:
### 1. Nepieciešams instalēt Ruby (3.3.0)
To var izdarīt šeit: https://rubyinstaller.org/downloads/.
Lai apskatītos esošo ruby versiju, izmanto komandu:
```bash
ruby -v
```

### 2. Nepieciešams insatlēt Rails
To var izdarīt ar komandu:
```bash
gem install rails
```

### 3. Nepieciešams instalēt Bundler
```bash
gem install bundler
```

## Soļi paša projekta uzstādīšanai

### 1. Klonē repositoriju
```bash
git clone https://github.com/xsabx/BikeRentalWebApp.git
```

### 2. Dodies uz projekta direktoriju 
```bash
cd <project-directory>
```
Šajā solī var atvērt editoru (piemēram, VScode ar komandu "code ." vai atvērt kolonēto mapi manuāli)

### 3. Veic nepieciešamās instalācijas projektā
```bash
bundle install
```

### 4. Izveido datubāzi
```bash
rails db:create
rails db:migrate
rails db:seed
```
NOTICE! Datubāzē jābūt tieši 5 izrādēm (ar bildi katram), ja, izveidojot datubāzi, tās failā dati neatbilst šim nosacījumam, datubāzes izveides procesā ir bijuši traucējumi. Var manuāli izdzēst development.sqlite3 failu un atkārtot komandas.

### 5. Startē projektu
```bash
rails server
```

Projekts būs pieejams [http://localhost:3000](http://localhost:3000).

Ja uz Windows netiek izmantota Windows Linux Subsistēma, terminālis jāatver kā administratoram, lai būtu visas nepieciešamas tiesības.





