desc 'import'
task :import => :environment do
  require 'csv'
  #---import services---
  services = {}
  services_seeds = [
    {:code => 'degs', :name => 'Donor Egg Services'},
    {:code => 'gs', :name => 'Gestational Surrogate'},
    {:code => 'dems', :name => 'Donor Embryo Services'},
    {:code => 'c', :name => 'Cryopreservation'},
    {:code => 'sw', :name => 'Services for Single Women'},
    {:code => 'aal', :name => 'ACS Accredited Laboratory'},
    {:code => 'is', :name => 'ICSI Services'},
    {:code => 'pgd', :name => 'Preimplantation Genetic Diagnosis'}
  ]

  services_seeds.each do |s|
    service = Service.create! s
    services[service[:code]] = service
  end

  #---import ages---
  ages_seeds = [
    {:code => '35', :name => '<35', :min => 0, :max => 34},
    {:code => '37', :name => '35-37', :min => 35, :max => 37},
    {:code => '40', :name => '38-40', :min => 38, :max => 40},
    {:code => '42', :name => '41-42', :min => 41, :max => 42},
    {:code => '44', :name => '43-44', :min => 43, :max => 44},
  ]

  ages_seeds.each do |a|
    Age.create! a
  end

  #---import complications---
  complications = {}
  complications_seeds = [
    {:code => 'tf', :name => 'Tubal Factor'},
    {:code => 'od', :name => 'Ovulatory Dysfunction'},
    {:code => 'dor', :name => 'Diminished Ovarian Reserve'},
    {:code => 'e', :name => 'Endometriosis'},
    {:code => 'uf', :name => 'Uterine Factor'},
    {:code => 'mf', :name => 'Male Factor'},
    {:code => 'mff', :name => 'Male and Female Factor'},
    {:code => 'fgd', :name => 'Familial Genetic Disease'}
  ]

  complications_seeds.each do |c|
    complication = Complication.create! c
    complications[complication[:code]] = complication
  end

  #---Link Complications with Required Services---
  complications['dor'].services << services['degs']
  complications['dor'].services << services['dems']
  complications['uf'].services << services['gs']
  complications['mf'].services << services['is']
  complications['fgd'].services << services['pgd']
  complications['mff'].services << services['is']
  complications['tf'].services = Service.all
  complications['e'].services = Service.all

  complications.each do |key, complication|
    complication.save!
  end

  #---import clinics---
  clinics = {}
  filename = File.join(Rails.root, 'db/seeds/clinics.csv')
  CSV.foreach(filename, :headers => true, :header_converters => :symbol) do |row|
    clinic = Clinic.create!({
        :clinic_id => row[:clinic_id],
        :name => row[:clinic_name],
        :address => row[:address],
        :city => row[:city],
        :state => row[:state],
        :zip => row[:zip],
        :practice_director => row[:practice_director],
        :medical_director => row[:medical_director],
        :lab_director => row[:lab_director],
        :phone => row[:phone],
        :fax => row[:fax],
        :link => row[:link],
        :email => row[:email]
      })

    clinics[row[:clinic_id]] = clinic

    service_codes = [
      :degs,
      :gs,
      :dems,
      :c,
      :sw,
      :aal,
      :is,
      :pgd
    ]
    service_codes.each do |code|
      if row[code].to_s == '1'
        clinic.services << Service.find_by_code(code)
      end
    end

    clinic.save
  end

  #---import egg types---
  egg_types_seeds = [
    {:code => 'frozen', :name => 'Frozen Egg'},
    {:code => 'donor', :name => 'Fresh Egg'},
    {:code => 'fresh', :name => 'Donor Egg'}
  ]

  egg_types_seeds.each do |e|
    EggType.create! e
  end

  #---import stat names---
  stat_names_seeds = [
    {:code => 'totcycles', :name => 'Total IVF Cycles'},
    {:code => 'preg', :name => 'Pregnancy Rate'},
    {:code => 'birth', :name => 'Birth Rate'},
    {:code => 'rank', :name => 'Rank'}
  ]

  stat_names_seeds.each do |s|
    StatName.create! s
  end

   #---import stats---
  stats = {}
  filename = File.join(Rails.root, 'db/seeds/stats.csv')
  CSV.foreach(filename, :headers => true) do |row|
    ages = [35, 37, 40, 42, 44]
    egg_types = ['frozen', 'fresh', 'donor']
    stats = ['totcycles', 'preg', 'birth', 'rank']
    clinic = Clinic.find_by_clinic_id(row['clinic_id'].to_i)
    clinic.update_attributes({
                              :donor_transfers => row[38].to_i,
                              :donor_births => row[39],
                              :donor_rank => row[40]
                             })

    ages.each do |age|
      egg_types.each do |egg_type|
        stats.each do |stat|
          header = [age, egg_type, stat].join('_')
          Stat.create!(
              :age_id => Age.find_by_code(age).id,
              :egg_type_id => EggType.find_by_code(egg_type).id,
              :clinic_id => clinic.id,
              :stat_name_id => StatName.find_by_code(stat).id,
              :value => row[header]
          )
        end
      end
    end
  end
end