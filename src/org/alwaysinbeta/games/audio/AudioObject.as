package org.alwaysinbeta.games.audio {
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;

	/**
	 * @author McFamily
	 */
	public class AudioObject {
		private var _sound : Sound;
		private var _loop : Boolean;
		private var _isPlaying : Boolean;
		private var _startTime : Number = 0;
		private var _channel : SoundChannel;
		private var _soundTransform : SoundTransform;
		private var _volume : Number = 1;
		private var _pan : Number = 0;

		public function AudioObject(sound : Sound = null, loop : Boolean = false) {
			trace("AudioObject.AudioObject(",sound, loop,")");
			_loop = loop;
			_sound = sound;
			_soundTransform = new SoundTransform(_volume, _pan);
		}

		public function get isPlaying() : Boolean {
			return _isPlaying;
		}

		public function play(startTime : Number = 0) : SoundChannel {
			if (!_sound) return null;
			_startTime = startTime;
			_isPlaying = true;
			if (_channel) stop();

			var loops : int = _loop ? 99999 : 0;
			_channel = _sound.play(_startTime, loops, _soundTransform);

			if (!_channel) {
				trace("[WARNING] AudioObject.play => run out of SoundChannel");
				_isPlaying = false;
			}

			return _channel;
		}

		public function stop() : void {
			_isPlaying = false;

			if (_channel) {
				_channel.stop();
			}
		}

		public function resume() : void {
			play(_startTime);
		}

		public function pause() : void {
			stop();

			if (_channel) {
				_startTime = _channel.position;
			}
		}

		public function set volume(value : Number) : void {
			if (isNaN(value)) return;
			if (_volume == value) return;

			_volume = _soundTransform.volume = value;
			_channel.soundTransform = _soundTransform;
		}

		public function set pan(value : Number) : void {
			if (isNaN(value)) return;
			if (_pan == value) return;

			_pan = _soundTransform.pan = value;
			_channel.soundTransform = _soundTransform;
		}
	}
}
