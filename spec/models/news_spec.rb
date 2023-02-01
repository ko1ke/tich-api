require 'rails_helper'

describe News do
  it 'has a valid factory' do
    expect(build(:news)).to be_valid
  end

  describe 'methods' do
    describe '#favored_by_user?' do
      let(:favorite) { create(:favorite) }

      context 'with favored users' do
        it 'is expected return true' do
          expect(favorite.news.favored_by_user?(favorite.user.id)).to be_truthy
        end
      end
      context 'without favored users' do
        it 'is expected return false' do
          another_user = create(:user)
          expect(favorite.news.favored_by_user?(another_user.id)).to be_falsy
        end
      end
    end

    describe 'News.search' do
      let(:favorite) { create(:favorite) }

      context 'with favored news by user' do
        context 'and no keywords' do
          it 'is expected return matched news' do
            news = favorite.news
            expect(News.search('', favorite.user.id).first).to eq news
          end
        end
        context 'and a keyword to be matched' do
          it 'is expected return matched news' do
            news = favorite.news
            expect(News.search(news.headline, favorite.user.id).first).to eq news
            expect(News.search(news.body, favorite.user.id).first).to eq news
          end
        end
        context 'and a keyword not to be matched' do
          it 'is not expected return matched news' do
            news = favorite.news
            expect(News.search(SecureRandom.hex(5), favorite.user.id).first).not_to eq news
          end
        end
      end
      context 'withoout favored news by user' do
        it 'is expected return matched news' do
          news = favorite.news
          another_user = create(:user)
          expect(News.search('', another_user.id).first).not_to eq news
        end
      end
    end
  end
end
