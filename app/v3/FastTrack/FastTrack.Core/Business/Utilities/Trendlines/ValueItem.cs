using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FastTrack.Core.Business.Utilities.Trendlines
{
    /// <summary>
    /// Base class for value items
    /// </summary>
    /// <typeparam name="TX">Type definition for X</typeparam>
    public abstract class ValueItem<TX> : IValueItem
    {

        private double _y;

        /// <summary>
        /// Raised when the data in the item is changed
        /// </summary>
        public event System.ComponentModel.PropertyChangedEventHandler PropertyChanged;

        /// <summary>
        /// The actual value for X
        /// </summary>
        public abstract TX X { get; set; }

        /// <summary>
        /// The value for X for calculations
        /// </summary>
        public abstract double ConvertedX { get; set; }

        /// <summary>
        /// Y value of the data item
        /// </summary>
        public double Y
        {
            get
            {
                return this._y;
            }
            set
            {
                if (this._y != value)
                {
                    this._y = value;
                    this.NotifyPropertyChanged("Y");
                }
            }
        }

        /// <summary>
        /// This method fires the property changed event
        /// </summary>
        /// <param name="propertyName">Name of the changed property</param>
        protected void NotifyPropertyChanged(string propertyName)
        {
            System.ComponentModel.PropertyChangedEventHandler handler = this.PropertyChanged;

            if (handler != null)
            {
                handler(this, new System.ComponentModel.PropertyChangedEventArgs(propertyName));
            }
        }

        /// <summary>
        /// Creates a copy of the value item
        /// </summary>
        /// <returns>The copy</returns>
        public abstract object CreateCopy();

        /// <summary>
        /// Creates a new trend item
        /// </summary>
        /// <returns>The trend item</returns>
        public abstract object NewTrendItem();
    }
}
