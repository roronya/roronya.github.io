import panflute as pf


def extract_title(doc):
    # ドキュメントを走査して最初のh1見出しを探す
    for elem in doc.content:
        if isinstance(elem, pf.Header) and elem.level == 1:
            title = pf.stringify(elem)
            doc.metadata['title'] = pf.MetaString(title)
            break  # 最初のh1見出しのみを使用

def extract_description(doc):
    text = ''.join(pf.stringify(block) for block in doc.content)
    description = text[:90]
    # メタデータに追加
    doc.metadata['description'] = pf.MetaString(description)

def convert_slug_to_date(doc):
    # メタデータからslugを取得
    slug = doc.get_metadata('slug', None)
    if slug:
        # slugの形式から日付を抽出して変換
        year = slug[:4]
        month = slug[4:6]
        day = slug[6:8]
        date_str = f"{year}年{month}月{day}日"

        # 新しいメタデータフィールドに変換した日付を追加
        doc.metadata['date'] = pf.MetaString(date_str)

def main(doc=None):
    doc = pf.load(input_stream=None)
    extract_title(doc)
    extract_description(doc)
    convert_slug_to_date(doc)
    pf.dump(doc)

if __name__ == "__main__":
    main()

