using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FastTrack.Core.Business.Utilities.Trendlines
{
    /// <summary>
    /// Class for number items where X is datetime
    /// </summary>
    public class DateItem : ValueItem<System.DateTime>
    {

        private System.DateTime _x;

        /// <summary>
        /// X actual value of the data item
        /// </summary>
        public override System.DateTime X
        {
            get
            {
                return this._x;
            }

            set
            {
                if (this._x != value)
                {
                    this._x = value;
                    this.NotifyPropertyChanged("X");
                }
            }
        }

        /// <summary>
        /// The value for X for calculations
        /// </summary>
        public override double ConvertedX
        {
            get
            {
                double returnValue = 0;

                if (this.X != null)
                {
                    returnValue = this.X.ToOADate();
                }

                return returnValue;
            }
            set
            {
                System.DateTime converted = System.DateTime.FromOADate(value);

                if (this.X != converted)
                {
                    this.X = converted;
                }
            }
        }
        /// <summary>
        /// Creates a new trend item
        /// </summary>
        /// <returns>The trend item</returns>
        public override object NewTrendItem()
        {
            return new DateItem();
        }

        /// <summary>
        /// Creates a copy of the value item
        /// </summary>
        /// <returns>The copy</returns>
        public override object CreateCopy()
        {
            return new DateItem()
            {
                X = this.X,
                Y = this.Y
            };
        }
    }
}
