FactoryBot.define do
  factory :video do
    id {1}
    user_id {1}
    name {"testvid"}
    playlist_url {"https://youtube-clone-bucket-processed.s3.ap-south-1.amazonaws.com/testvid/testvid.m3u8"}
    thumbnail_url {"https://youtube-clone-bucket-processed.s3.ap-south-1.amazonaws.com/testvid/thumb.png"}
    file_name {"testvid.mp4"}
  end
end
