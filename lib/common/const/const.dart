import '../../domain/model/story/book_type.dart';
import '../../domain/model/story/list_item_data.dart';
import '../../domain/model/story/story_label_data.dart';

const keyGoogleApi = '';
const dbVersion = 1;

final koAlbums = {
  'Recents': "최근 항목",
  "Favorites": "즐겨찾기 항목",
  "Videos": "동영상",
  "Selfies": "셀카",
  "Live Photos": "라이브 사진",
  "Portrait": "인물 사진",
  "Long Exposure": "장시간 노출",
  "Spatial": "공간",
  "Panoramas": "파노라마",
  "Time-lapse": "타임랩스",
  "Slo-mo": "슬로모션",
  "Cinematic": "시네마틱",
  "Bursts": "버스트",
  "Screenshots": "스크린샷",
  "Animated": "애니메이션",
  "RAW": "RAW",
  "Hidden": "숨겨진 항목",
  "KAKAO STORY": "카카오 스토리",
  "dcinside": "디시인사이드",
  "Instagram": "인스타그램",
};

final storyLabelDataList = [
  StoryLabelData(
    iconPath: 'assets/icons/ic_story_step_01.png',
    description: '어떤 종류의 여행인가요?',
    label: '여행종류',
  ),
  StoryLabelData(
    iconPath: 'assets/icons/ic_story_step_02.png',
    description: '여행 사진을 추가해 주세요.',
    label: '사진선택',
  ),
  StoryLabelData(
    iconPath: 'assets/icons/ic_story_step_03.png',
    description: '여행에 관한 부족한 정보를 채워 주세요.',
    label: '세부조정',
  ),
  StoryLabelData(
    iconPath: 'assets/icons/ic_story_step_04.png',
    description: '원하시는 글의 형태를 선택해 주세요.',
    label: '유형선택',
  ),
  StoryLabelData(
    iconPath: 'assets/icons/ic_story_step_05.png',
    description: 'AI 김작가가 작성한 글을 확인해 주세요.?',
    label: '내용확인',
  ),
  StoryLabelData(
    iconPath: 'assets/icons/ic_story_step_06.png',
    description: '마음에 드는 표지 양식을 선택해 주세요.',
    label: '템플릿',
  ),
  StoryLabelData(
    iconPath: 'assets/icons/ic_story_step_07.png',
    description: '마음에 쏙 들었으면 좋겠습니다.',
    label: '완성',
    activeLabel: '생성중',
  ),
];

final travelTypeDataList = [
  ListItemData(
    thumbnail: 'assets/images/img_travel_type_01.png',
    title: '신혼 여행',
    description: '결혼 후 처음으로 떠나는 여행',
  ),
  ListItemData(
    thumbnail: 'assets/images/img_travel_type_02.png',
    title: '가족 여행',
    description: '가족과 함께 떠나는 여행',
  ),
  ListItemData(
    thumbnail: 'assets/images/img_travel_type_03.png',
    title: '커플 여행',
    description: '둘만의 특별한 시간을 찾아 떠나는 여행',
  ),
  ListItemData(
    thumbnail: 'assets/images/img_travel_type_04.png',
    title: '나홀로 여행',
    description: '자유와 휴식을 찾아 혼자 따나는 여행',
  ),
  ListItemData(
    thumbnail: 'assets/images/img_travel_type_05.png',
    title: '친구와의 여행',
    description: '친구들과 우정을 쌓기 위한 여행',
  ),
];

final vibeDataList = [
  ListItemData(
    thumbnail: 'assets/icons/ic_vibe_01.png',
    title: '행복',
    description: '행복한 여행',
  ),
  ListItemData(
    thumbnail: 'assets/icons/ic_vibe_02.png',
    title: '멋진',
    description: '멋진 여행',
  ),
  ListItemData(
    thumbnail: 'assets/icons/ic_vibe_03.png',
    title: '감동',
    description: '감동적인 여행',
  ),
  ListItemData(
    thumbnail: 'assets/icons/ic_vibe_04.png',
    title: '놀람',
    description: '놀라운 여행',
  ),
  ListItemData(
    thumbnail: 'assets/icons/ic_vibe_05.png',
    title: '황홀',
    description: '황홀한 여행',
  ),
  ListItemData(
    thumbnail: 'assets/icons/ic_vibe_06.png',
    title: '화남',
    description: '화가 나는 여행',
  ),
  ListItemData(
    thumbnail: 'assets/icons/ic_vibe_07.png',
    title: '지루',
    description: '지루한 여행',
  ),
  ListItemData(
    thumbnail: 'assets/icons/ic_vibe_08.png',
    title: '피곤',
    description: '피곤한 여행',
  ),
];

final weatherDataList = [
  ListItemData(
    thumbnail: 'assets/icons/ic_weather_01d.png',
    title: '맑음',
    description: '맑은 날씨',
  ),
  ListItemData(
    thumbnail: 'assets/icons/ic_weather_02d.png',
    title: '구름조금',
    description: '구름 조금 있는 날씨',
  ),
  ListItemData(
    thumbnail: 'assets/icons/ic_weather_03d.png',
    title: '구름많음',
    description: '구름이 많이 있는 날씨',
  ),
  ListItemData(
    thumbnail: 'assets/icons/ic_weather_04d.png',
    title: '흐림',
    description: '흐린 날씨',
  ),
  ListItemData(
    thumbnail: 'assets/icons/ic_weather_09d.png',
    title: '소나기',
    description: '소나기 비가 내리는 날씨',
  ),
  ListItemData(
    thumbnail: 'assets/icons/ic_weather_10d.png',
    title: '비',
    description: '비가 내리는 날씨',
  ),
  ListItemData(
    thumbnail: 'assets/icons/ic_weather_11d.png',
    title: '뇌우',
    description: '천둥 번개가 치는 날씨',
  ),
  ListItemData(
    thumbnail: 'assets/icons/ic_weather_13d.png',
    title: '눈',
    description: '눈이 내리는 날씨',
  ),
  ListItemData(
    thumbnail: 'assets/icons/ic_weather_50d.png',
    title: '안개',
    description: '안개가 낀 날씨',
  ),
];

final List<BookType> bookTypeList = [
  BookType(
    imagePath: 'assets/images/img_book_type_01.png',
    type: '에세이',
  ),
  BookType(
    imagePath: 'assets/images/img_book_type_02.png',
    type: '시',
  ),
  BookType(
    imagePath: 'assets/images/img_book_type_04.png',
    type: '포스팅',
  ),
  BookType(
    imagePath: 'assets/images/img_book_type_03.png',
    type: '매거진',
  ),
];


final List<String> textStyleList = [
  '격식있는 글',
  '친근한 글',
  '유머있는 글',
  '감동적인 글'
];

final Map<String, List<String>> textStyleMap = {
  '에세이' : ['아인슈타인 (과학/설명체)', '이병률 ex) 바람이 분다', '이순신 ex) 난중일기', '무라카이 하루키'],
  '시' : ['윤동주', '류시화', '김소월', '김영랑'],
  '포스팅' : ['블로그'],
  '매거진' : ['여행스케치', '트래비', '월간 산'],
};