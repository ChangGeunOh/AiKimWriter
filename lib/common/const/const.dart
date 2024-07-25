import '../../domain/model/story/book_type.dart';
import '../../domain/model/story/list_item_data.dart';
import '../../domain/model/story/story_label_data.dart';


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
  '에세이': ['아인슈타인 (과학/설명체)', '이병률 ex) 바람이 분다', '이순신 ex) 난중일기', '무라카이 하루키'],
  '시': ['윤동주', '류시화', '김소월', '김영랑'],
  '포스팅': ['블로그'],
  '매거진': ['여행스케치', '트래비', '월간 산'],
};

const aiStorySample = '''2024년 2월 11일 (일) - 고르너그라트와 설산 하이킹
스위스 여행의 첫날은 고르너그라트에서 시작되었다. 처음 고르너그라트에 올라갈 때는 날씨가 흐려서 기대가 크지 않았다. 그러나 정상에 도착하자 마치 마법처럼 구름이 사라지면서 봉우리가 선명하게 드러났다. 그 순간의 아름다움은 말로 표현하기 어려울 정도였다. 눈 덮인 봉우리들이 끝없이 펼쳐진 풍경은 가슴을 뛰게 했다.
정상에서 내려와 로텐보덴을 지나 리펠베르크와 리펠알프까지 설산 하이킹을 했다. 하이킹 중에는 한겨울의 아름다운 자연 속에서 조용하고 평화로운 시간을 보낼 수 있었다. 차가운 공기와 새하얀 눈이 만들어내는 고요함 속에서 걷는 경험은 그야말로 특별했다.

2024년 2월 12일 (월) - 루체른의 뜻밖의 축제
이튿날, 루체른을 방문했다. 기차에서 내리자마자 나는 예상치 못한 광경에 놀랐다. 거리에는 이상한 코스튬을 입은 사람들이 가득했고, 알고 보니 지역 축제가 한창이었다. 갑작스런 축제 분위기에 처음에는 당황했지만, 곧 즐거움에 빠져들었다.
루체른 호수에서 크루즈를 타고 리기산 정상에 올랐다. 정상에서 내려다보는 경치는 환상적이었다. 다시 루체른으로 돌아와 축제에 참여했다. 거리 곳곳에서 다양한 공연과 퍼레이드가 펼쳐졌고, 그 열기와 흥분 속에서 하루를 보냈다. 뜻밖의 멋진 이벤트를 경험하게 되어 너무 기뻤다.

2024년 2월 13일 (화) - 융프라우요흐와 아이거 워크
여행의 마지막 날은 대망의 융프라우요흐 방문으로 시작되었다. 아이거글렛처에서 융프라우요흐까지 케이블카를 타고 올라갔다. 날씨는 맑았고, 융프라우의 봉우리가 선명하게 보였다. 엄청난 추위 속에서도 한 시간 동안 정상에서 사진을 찍으며 그 장엄한 풍경을 만끽했다.
정상을 내려오면서 다시 아이거글렛처에 도착한 후, 클라이네 샤이덱까지 아이거 워크를 하며 설산 하이킹을 즐겼다. 하이킹 도중 바라본 알프스의 풍경은 너무나 아름답고 낭만적이었다. 눈 덮인 산길을 걸으며, 한걸음 한걸음이 여행의 마지막을 아쉬워하게 만들었다.''';
