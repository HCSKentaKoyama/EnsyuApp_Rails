class Report < ApplicationRecord

    def checkboxToArray(checkboxResult)
        str = ""
        checkboxResult.each do |di1,di2|
            if di2  == "1"
                str = str + di1
                str = str + ","
            end
        end
        str = str.chomp(",")
        return str
    end

    def getHashMethod()
        hash_method = {
            "": "",
            "0": "学校斡旋",
            "1": "斡旋サイト",
            "2": "企業HP",
            "3": "新聞雑誌",
            "4": "ジョブカフェ等",
            "9": "その他"
        }
        return hash_method
    end

    def getHashContent()
        hash_content = {
            "": "",
            "0": "適正",
            "1": "筆記・作文",
            "2": "ディスカッション",
            "3": "グループワーク",
            "4": "集団面接",
            "5": "個人面接",
            "9": "その他"
        }
        return hash_content
    end

    def getHashDetail()
        hash_detail = {
            "": "",
            "0": "SPI",
            "1": "CAB/GAB",
            "2": "職業適性",
            "3": "クレペリン",
            "4": "その他適正",
            "5": "一般常識",
            "6": "専門知識",
            "7": "作文",
            "8": "個人面接",
            "9": "集団面接",
            "a": "グループディスカッション",
            "b": "グループワーク",
            "z": "その他"
        }
        return hash_detail
    end

    def getHashGrade()
        hash_grade = {
            "0": "1次試験",
            "1": "2次試験",
            "2": "3次試験",
            "3": "4次試験",
            "9": "最終試験"
        }
        return hash_grade
    end

    def getHashNotice()
        hash_notice = {
            "0": "1週間以内に本人",
            "1": "2週間以内に本人",
            "2": "2週間以内に本人",
            "3": "1週間以内に学校",
            "4": "2週間以内に学校",
            "5": "2週間以内に学校",
            "9": "その他"
        }
        return hash_notice
    end

    def getHashResult()
        hash_result = {
            "": "",
            "0": "合格",
            "1": "不合格"
        }
        return hash_result
    end
end
